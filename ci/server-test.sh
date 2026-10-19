#!/usr/bin/env bash
# Boots a vanilla 1.21.11 dedicated server with the Chaos Hearts datapack and resource pack, checks that every
# function loaded, plays a two-player scenario with vanilla-protocol bots (ci/bots), restarts the server to check
# persistence, then checks the log for errors.
# Usage: ci/server-test.sh <dir containing chaoshearts-datapack.zip and chaoshearts-resourcepack.zip>
set -uo pipefail

DIST=$(realpath "$1")
ROOT=$(pwd)
MC=1.21.11
SERVER="$ROOT/ci-server"
rm -rf "$SERVER"
mkdir -p "$SERVER/world/datapacks" "$SERVER/www"
cd "$SERVER" || exit 1

URL=$(curl -fsSL https://piston-meta.mojang.com/mc/game/version_manifest_v2.json | jq -r --arg v "$MC" '.versions[] | select(.id==$v) | .url')
SURL=$(curl -fsSL "$URL" | jq -r '.downloads.server.url')
echo "Vanilla $MC server: $SURL"
curl -fsSL -o server.jar "$SURL" || exit 1
cp "$DIST/chaoshearts-datapack.zip" world/datapacks/
cp "$DIST/chaoshearts-resourcepack.zip" www/
SHA=$(sha1sum www/chaoshearts-resourcepack.zip | cut -d' ' -f1)
(cd www && python3 -m http.server 8000 >/dev/null 2>&1 &)

echo "eula=true" > eula.txt
cat > server.properties <<P
online-mode=false
spawn-protection=0
view-distance=6
simulation-distance=6
level-seed=chaos
level-type=minecraft\:flat
generate-structures=false
server-port=25565
enable-command-block=true
resource-pack=http\://127.0.0.1\:8000/chaoshearts-resourcepack.zip
resource-pack-sha1=$SHA
require-resource-pack=false
P

mkfifo console
exec 3<>console
touch server.log

start_server() {
	java -Xmx2G -jar server.jar --nogui < console >> server.log 2>&1 &
	PID=$!
}

stop_server() {
	echo "stop" >&3
	for _ in $(seq 120); do kill -0 "$PID" 2>/dev/null || break; sleep 1; done
	if kill -0 "$PID" 2>/dev/null; then echo "Server did not stop"; kill -9 "$PID"; return 1; fi
	wait "$PID" || true
}

wait_for() { # pattern, seconds, how many occurrences
	for _ in $(seq "$2"); do
		if [ "$(grep -c "$1" server.log)" -ge "${3:-1}" ]; then return 0; fi
		if ! kill -0 "$PID" 2>/dev/null; then echo "Server exited early"; tail -200 server.log; return 1; fi
		sleep 1
	done
	echo "Timed out waiting for: $1"; tail -100 server.log; return 1
}

say() { echo "$1" >&3; sleep "${2:-1}"; }

start_server
wait_for 'Done (' 600 || exit 1
say "datapack list enabled" 2
say "execute in ch:trials run say trials-dimension-ok"
say "function ch:admin/help"

{
	echo "=== Datapack load ==="
	n=$(grep -c "Failed to load function" server.log)
	echo "functions that failed to load: $n"
	grep -A3 "Failed to load function" server.log | grep -vE '^\s+at ' | head -400
	grep -E "Couldn't load|Failed to parse|Error loading|Unknown dialog|Couldn't parse" server.log | head -100
} | tee -a test-summary.txt

BOT_FAIL=
echo "Installing the bot client"
(cd "$ROOT/ci/bots" && npm install --no-audit --no-fund --silent) || BOT_FAIL=1
export CONSOLE_FIFO="$SERVER/console" SERVER_LOG="$SERVER/server.log" MC_VERSION="$MC" PACK_SHA1="$SHA"
echo "=== Multiplayer scenario ===" | tee -a test-summary.txt
timeout 1500 node "$ROOT/ci/bots/test.js" main 2>&1 | tee -a test-summary.txt || BOT_FAIL=1
echo "=== After a server restart ===" | tee -a test-summary.txt
stop_server
start_server
if wait_for 'Done (' 600 2; then
	timeout 300 node "$ROOT/ci/bots/test.js" after-restart 2>&1 | tee -a test-summary.txt || BOT_FAIL=1
else
	BOT_FAIL=1
fi
stop_server

{
	echo "=== Runtime errors in the log ==="
	grep -E "ERROR|Exception" server.log | grep -vE "^\s+at " | sort | uniq -c | sort -rn | head -60
	echo "Ticks behind warnings: $(grep -c "Can't keep up" server.log)"
} | tee -a test-summary.txt

fail=0
check() { if ! grep -q "$1" server.log; then echo "MISSING: $1"; fail=1; fi; }
check 'Done ('
check 'trials-dimension-ok'
check 'Stopping server'
if grep -q "Failed to load function" server.log; then echo "Some functions failed to load"; fail=1; fi
if [ -n "$BOT_FAIL" ]; then echo "Bot scenario failed"; fail=1; fi
exit $fail
