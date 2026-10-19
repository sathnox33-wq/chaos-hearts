# The pupil looks at the player being gazed at, else the nearest other player, else where the Eye looks.
execute if entity @a[tag=ch.gazed,distance=..64,limit=1] run return run tp @s ~ ~ ~ facing entity @a[tag=ch.gazed,distance=..64,limit=1] eyes
execute if entity @a[tag=!ch.eyeself,distance=..20,gamemode=!spectator,limit=1] run return run tp @s ~ ~ ~ facing entity @a[tag=!ch.eyeself,distance=..20,gamemode=!spectator,sort=nearest,limit=1] eyes
tp @s ~ ~ ~ ~ ~
