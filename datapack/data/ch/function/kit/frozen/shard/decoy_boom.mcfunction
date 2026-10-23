# The decoy bursts: 5 damage and slowness within 3.5 blocks; those within 2 freeze solid.
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.5 0.8 0.5 0.25 60
particle minecraft:snowflake ~ ~1 ~ 1.5 1 1.5 0.08 40
execute positioned ~ ~0.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:10217471,s0:0.5,s1:7.0,t:4,life:9,spin:90,dy:0.0}
function ch:api/fx/sprite {model:"star",color:15924223,s0:0.5,s1:5.0,t:3,life:7,spin:170,dy:1.0}
execute rotated 0 0 run function ch:api/fx/wave {color:10217471,r:3.5,t:5}
function ch:api/fx/shake {s:2,t:6,r:9}
function ch:api/fx/light {t:4}
playsound chaoshearts:frozen_shatter player @a ~ ~ ~ 1.4 1.2
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.2 0.7
scoreboard players set #f_dmg ch.tmp 50
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5] at @s run function ch:kit/frozen/shard/rain_one
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2] at @s run function ch:kit/frozen/shard/decoy_core
