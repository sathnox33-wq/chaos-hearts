# The fracture shatters. Chrono Collapse implodes; Rewind pulls the owner back through time.
function ch:api/tag_owner
scoreboard players operation #fo ch.speed.g = @s ch.owner
scoreboard players operation #fh ch.speed.g = @s ch.v3
execute if score @s ch.v2 matches 1 run function ch:kit/speed/frac/collapse with storage ch:kspeed f
function ch:kit/speed/frac/release with storage ch:kspeed f
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16777215,s0:0.5,s1:10.0,t:4,life:12,spin:30,dy:0.0}
function ch:api/fx/orb {color:15267583,s:3.0,t:2,life:5}
particle minecraft:end_rod ~ ~1.5 ~ 2 1.5 2 0.3 80
particle minecraft:block{block_state:"minecraft:glass"} ~ ~1.5 ~ 2 1.5 2 0 60
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.5 0.6
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.5 1.2
playsound minecraft:block.bell.use player @a ~ ~ ~ 1.2 1.5
playsound chaoshearts:speed_timefracture player @a ~ ~ ~ 1 1.5
execute if score @s ch.v6 matches 1 as @a[tag=ch.caster,limit=1] run function ch:kit/speed/frac/rewind
execute as @e[type=marker,tag=ch.speed.anchor,distance=..80] if score @s ch.owner = #fo ch.speed.g run kill @s
tag @a remove ch.caster
kill @s
