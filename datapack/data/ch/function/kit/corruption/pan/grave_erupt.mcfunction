# Later: hands of the dead burst up under the nearest enemies (6 damage, rooted 1 s); each one becomes a Rotling.
scoreboard players operation #cll ch.tmp = @s ch.v1
scoreboard players operation #cln ch.tmp = @s ch.v2
scoreboard players operation #cnec ch.tmp = @s ch.v3
scoreboard players set #cd ch.tmp 60
scoreboard players set #ci ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..12,sort=nearest,limit=7] at @s run function ch:kit/corruption/pan/grave_one
playsound minecraft:entity.zombie.break_wooden_door player @a ~ ~ ~ 1 0.5
playsound chaoshearts:corruption_spread player @a ~ ~ ~ 1.4 0.7
function ch:api/fx/shake {s:3,t:8,r:16}
function ch:kit/corruption/pan/ring
