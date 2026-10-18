Chaos Hearts for Minecraft Java 1.21.11 (Fabric). Server-side only: players join with an unmodded client.

**Server install:** put `chaoshearts-1.0.0.jar` and Fabric API 0.141.6+1.21.11 (or newer) in `mods/`. Then open port 25580 for the built-in resource pack host and set `packPublicUrl` in `config/chaoshearts.json`. The README explains how to host the pack elsewhere instead.

**Files**
- `chaoshearts-1.0.0.jar` is the mod. It already contains the datapack and resource pack.
- `chaoshearts-resourcepack.zip` is the resource pack, for hosting it yourself.
- `chaoshearts-resourcepack.zip.sha1` is the SHA-1 to put in `packExternalSha1`.

Every build is tested on a real 1.21.11 server. The test runs a two-player scenario: PvP heart drop and claim, combat logging, an Awakening Trial failed and won, the Eye's powers, and a restart.
