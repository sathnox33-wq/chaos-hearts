# Fires the shard (or three in a fan with Hailstorm).
scoreboard players set #f_dmg ch.tmp 50
execute if score @s ch.b2 matches 1.. run scoreboard players set #f_dmg ch.tmp 62
scoreboard players set #f_pc ch.tmp 2
execute if score @s ch.b2 matches 3.. run scoreboard players set #f_pc ch.tmp 4
scoreboard players set #f_yaw ch.tmp 0
function ch:kit/frozen/shard/launch
execute if score @s ch.b2 matches 5.. run function ch:kit/frozen/shard/fan
execute anchored eyes positioned ^ ^-0.2 ^1 rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:10217471,s0:0.3,s1:1.8,t:3,life:6,spin:150,dy:0.0}
execute anchored eyes positioned ^ ^-0.2 ^1 rotated ~ 90 run function ch:api/fx/sprite {model:"hex",color:15924223,s0:0.2,s1:1.1,t:3,life:6,spin:-150,dy:0.0}
execute anchored eyes positioned ^ ^-0.2 ^1 run particle minecraft:snowflake ~ ~ ~ 0.15 0.15 0.15 0.06 14
playsound chaoshearts:frozen_shard player @a ~ ~ ~ 1 1
playsound minecraft:entity.snow_golem.shoot player @a ~ ~ ~ 1 0.7
playsound minecraft:block.amethyst_block.hit player @a ~ ~ ~ 1 1.6
return 1
