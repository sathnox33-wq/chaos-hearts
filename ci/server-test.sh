#!/usr/bin/env bash
# Boots a real Fabric dedicated server with the freshly built mod and Fabric API, runs the admin
# commands from the console, plays a two-player scenario with vanilla-protocol bots (ci/bots),
# restarts the server to check persistence, then checks the log for errors.
# Usage: ci/server-test.sh <dir containing chaoshearts-<version>.jar>
set -uo pipefail

DIST=$(realpath "$1")
ROOT=$(pwd)
prop() { grep "^$1=" gradle.properties | cut -d= -f2; }
MC=$(prop minecraft_version)
LOADER=$(prop loader_version)
FAPI=$(prop fabric_api_version)

SERVER="$ROOT/ci-server"
rm -rf "$SERVER"
mkdir -p "$SERVER/mods"
cd "$SERVER" || exit 1

INSTALLER=$(curl -fsSL https://meta.fabricmc.net/v2/versions/installer | jq -r '.[0].version')
echo "Fabric $MC, loader $LOADER, installer $INSTALLER, Fabric API $FAPI"
curl -fsSL -o server.jar "https://meta.fabricmc.net/v2/versions/loader/$MC/$LOADER/$INSTALLER/server/jar" || exit 1
curl -fsSL -o mods/fabric-api.jar "https://maven.fabricmc.net/net/fabricmc/fabric-api/fabric-api/$FAPI/fabric-api-${FAPI//+/%2B}.jar" || exit 1
cp "$DIST"/chaoshearts-*.jar mods/

echo "eula=true" > eula.txt
cat > server.properties <<P
online-mode=false
spawn-protection=0
view-distance=6
simulation-distance=6
level-seed=chaos
server-port=25565
P

mkfifo console
# Keep the fifo open so the server never sees end-of-input.
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

say "chaosadmin registry"
say "chaosadmin trial list"
say "chaosadmin save"
say "chaosadmin reload"
say "execute in chaoshearts:trials run say trials-dimension-ok"
say "eye"

BOT_FAIL=
if [ -f "$ROOT/ci/bots/test.js" ]; then
	echo "Installing the bot client"
	(cd "$ROOT/ci/bots" && npm install --no-audit --no-fund --silent) || BOT_FAIL=1
	export CONSOLE_FIFO="$SERVER/console" SERVER_LOG="$SERVER/server.log" MC_VERSION="$MC"
	echo "=== Multiplayer scenario ===" | tee -a test-summary.txt
	node "$ROOT/ci/bots/test.js" main 2>&1 | tee -a test-summary.txt || BOT_FAIL=1
	echo "=== After a server restart ===" | tee -a test-summary.txt
	stop_server
	start_server
	if wait_for 'Done (' 600 2; then
		node "$ROOT/ci/bots/test.js" after-restart 2>&1 | tee -a test-summary.txt || BOT_FAIL=1
	else
		BOT_FAIL=1
	fi
fi

stop_server

fail=0
check() { if ! grep -q "$1" server.log; then echo "MISSING: $1"; fail=1; fi; }
reject() { if grep -E "$1" server.log; then echo "UNEXPECTED: $1"; fail=1; fi; }
check 'Done ('
check 'trials-dimension-ok'
check 'Stopping server'
reject 'Mixin apply .*failed|MixinTransformerError|InvalidInjectionException'
reject 'Exception.*chaoshearts|chaoshearts.*Exception|at net\.chaoshearts\.'
reject 'dimension did not load'
echo "Ticks behind warnings: $(grep -c "Can't keep up" server.log)"
if [ -n "$BOT_FAIL" ]; then echo "Bot scenario failed"; fail=1; fi
exit $fail
