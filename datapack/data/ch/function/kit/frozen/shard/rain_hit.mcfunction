# Icicle impact: 6 damage and slowness within 3 blocks; the bullseye (1.3) freezes solid.
particle minecraft:block{block_state:"minecraft:ice"} ~ ~0.5 ~ 1.5 0.3 1.5 0.2 60
particle minecraft:snowflake ~ ~1 ~ 2 0.5 2 0.05 40
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:10217471,s0:2.0,s1:6.5,t:3,life:30,spin:0,dy:0.0}
execute rotated 0 0 run function ch:api/fx/wave {color:15924223,r:3.0,t:5}
function ch:api/fx/shake {s:2,t:6,r:10}
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.4 0.8
playsound minecraft:block.pointed_dripstone.land player @a ~ ~ ~ 1.4 0.6
scoreboard players set #f_dmg ch.tmp 60
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3] at @s run function ch:kit/frozen/shard/rain_one
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.6] at @s run function ch:kit/frozen/shard/rain_core
