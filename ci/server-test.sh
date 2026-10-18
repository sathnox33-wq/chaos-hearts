#!/usr/bin/env bash
# Boots a real Fabric dedicated server with the freshly built mod and Fabric API,
# runs the admin commands from the console, then stops it and checks the log.
# Usage: ci/server-test.sh <dir containing chaoshearts-<version>.jar>
set -euo pipefail

DIST=$(realpath "$1")
ROOT=$(pwd)
prop() { grep "^$1=" gradle.properties | cut -d= -f2; }
MC=$(prop minecraft_version)
LOADER=$(prop loader_version)
FAPI=$(prop fabric_api_version)

SERVER="$ROOT/ci-server"
rm -rf "$SERVER"
mkdir -p "$SERVER/mods"
cd "$SERVER"

INSTALLER=$(curl -fsSL https://meta.fabricmc.net/v2/versions/installer | jq -r '.[0].version')
echo "Fabric $MC, loader $LOADER, installer $INSTALLER, Fabric API $FAPI"
curl -fsSL -o server.jar "https://meta.fabricmc.net/v2/versions/loader/$MC/$LOADER/$INSTALLER/server/jar"
FAPI_ENC=${FAPI//+/%2B}
curl -fsSL -o mods/fabric-api.jar "https://maven.fabricmc.net/net/fabricmc/fabric-api/fabric-api/$FAPI/fabric-api-$FAPI_ENC.jar"
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
java -Xmx2G -jar server.jar --nogui < console > server.log 2>&1 &
PID=$!

wait_for() { # pattern, seconds
	for _ in $(seq "$2"); do
		if grep -q "$1" server.log; then return 0; fi
		if ! kill -0 $PID 2>/dev/null; then echo "Server exited early"; cat server.log; return 1; fi
		sleep 1
	done
	echo "Timed out waiting for: $1"; tail -100 server.log; return 1
}

say() { echo "$1" >&3; sleep "${2:-1}"; }

wait_for 'Done (' 600

say "chaosadmin registry"
say "chaosadmin trial list"
say "chaosadmin save"
say "chaosadmin reload"
say "execute in chaoshearts:trials run say trials-dimension-ok"
say "eye"

if [ -n "${BOT_TEST:-}" ] && [ -f "$ROOT/ci/bots/test.js" ]; then
	echo "Running the multiplayer bot scenario"
	say "op Attacker"
	say "op Victim"
	(cd "$ROOT/ci/bots" && npm ci --silent && node test.js) || BOT_FAIL=1
fi

say "stop" 0
for _ in $(seq 120); do kill -0 $PID 2>/dev/null || break; sleep 1; done
kill -0 $PID 2>/dev/null && { echo "Server did not stop"; kill -9 $PID; exit 1; }
wait $PID || true

cat server.log

fail=0
check() { if ! grep -q "$1" server.log; then echo "MISSING: $1"; fail=1; fi; }
reject() { if grep -E "$1" server.log; then echo "UNEXPECTED: $1"; fail=1; fi; }
check 'Done ('
check 'trials-dimension-ok'
check 'Stopping server'
reject 'Mixin apply .*failed|MixinTransformerError|InvalidInjectionException'
reject 'Exception.*chaoshearts|chaoshearts.*Exception|at net\.chaoshearts\.'
reject 'dimension did not load'
[ -n "${BOT_FAIL:-}" ] && { echo "Bot scenario failed"; fail=1; }
exit $fail
