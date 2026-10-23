#!/usr/bin/env bash
# Films Chaos Hearts in a real Minecraft 1.21.11 client under Xvfb (software OpenGL): boots a vanilla server with the
# packs and the capture camera datapack, starts the client (portablemc, offline name "Cam") with the resource pack
# enabled, then runs director.js, which casts every ability with a bot and records each one with ffmpeg.
# Usage: ci/capture/capture.sh <dist dir> <output dir>
set -uo pipefail
DIST=$(realpath "$1")
OUT=$(realpath -m "$2")
ROOT=$(pwd)
MC=1.21.11
SERVER="$ROOT/cap-server"
CLIENT="$ROOT/cap-client"
mkdir -p "$OUT" "$SERVER/world/datapacks" "$CLIENT/resourcepacks"

cd "$SERVER" || exit 1
URL=$(curl -fsSL https://piston-meta.mojang.com/mc/game/version_manifest_v2.json | jq -r --arg v "$MC" '.versions[] | select(.id==$v) | .url')
curl -fsSL -o server.jar "$(curl -fsSL "$URL" | jq -r '.downloads.server.url')" || exit 1
cp "$DIST/chaoshearts-datapack.zip" world/datapacks/
(cd "$ROOT/ci/capture/datapack" && zip -qr "$SERVER/world/datapacks/capture.zip" .)
echo "eula=true" > eula.txt
cat > server.properties <<P
online-mode=false
spawn-protection=0
view-distance=6
simulation-distance=6
level-seed=chaos
level-type=minecraft\:flat
generate-structures=false
enable-command-block=true
allow-flight=true
P
mkfifo console
exec 3<>console
touch server.log
java -Xmx2G -jar server.jar --nogui < console >> server.log 2>&1 &
SPID=$!
for _ in $(seq 600); do grep -q 'Done (' server.log && break; sleep 1; done
echo "datapack list enabled" >&3

cp "$DIST/chaoshearts-resourcepack.zip" "$CLIENT/resourcepacks/"
cat > "$CLIENT/options.txt" <<O
version:4671
onboardAccessibility:false
tutorialStep:none
joinedFirstServer:true
skipMultiplayerWarning:true
pauseOnLostFocus:false
narrator:0
renderDistance:6
simulationDistance:6
maxFps:60
enableVsync:false
fov:0.25
guiScale:2
chatVisibility:2
soundCategory_master:0.0
resourcePacks:["vanilla","file/chaoshearts-resourcepack.zip"]
incompatibleResourcePacks:[]
O

Xvfb :99 -screen 0 1280x720x24 -nolisten tcp >/dev/null 2>&1 &
export DISPLAY=:99 LIBGL_ALWAYS_SOFTWARE=1
sleep 2
python3 -m pip install -q portablemc==4.4.1
portablemc --main-dir "$CLIENT" --work-dir "$CLIENT" start "$MC" -u Cam -s 127.0.0.1 --resolution 1280x720 \
	--jvm "$(command -v java)" > "$OUT/client.log" 2>&1 &
CPID=$!

(cd "$ROOT/ci/bots" && npm install --no-audit --no-fund --silent)
export CONSOLE_FIFO="$SERVER/console" SERVER_LOG="$SERVER/server.log" CAPTURE_OUT="$OUT"
NODE_PATH="$ROOT/ci/bots/node_modules" timeout 3600 node "$ROOT/ci/capture/director.js"
RC=$?

echo "stop" >&3
sleep 10
kill "$CPID" "$SPID" 2>/dev/null
grep -vE '^\s+at ' server.log | tail -4000 > "$OUT/server.log"
cp "$CLIENT/logs/latest.log" "$OUT/client-latest.log" 2>/dev/null

# Small web copies of the clips.
mkdir -p "$OUT/clips"
for f in "$OUT"/raw/*.mp4; do
	[ -f "$f" ] || continue
	ffmpeg -y -loglevel error -i "$f" -vf scale=960:-2 -c:v libx264 -preset medium -crf 30 -pix_fmt yuv420p \
		-movflags +faststart -an "$OUT/clips/$(basename "$f")"
done
rm -rf "$OUT/raw"
exit $RC
