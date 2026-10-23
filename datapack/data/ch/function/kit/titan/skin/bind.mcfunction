# Down: Rockbind. A stamp of the foot: stone grows over the legs of every enemy within 6 blocks; you harden a little.
scoreboard players set @s ch.titan.skm 2
scoreboard players set @s ch.titan.skin 80
effect give @s minecraft:resistance 4 0 true
attribute @s minecraft:knockback_resistance modifier add ch:titan_skin 1 add_value
scoreboard players set #ti_big ch.tmp 0
function ch:kit/titan/fx/ring8
function ch:kit/titan/fx/ring12
function ch:api/fx/wave {color:8025194,r:6,t:6}
particle minecraft:block{block_state:"minecraft:stone"} ~ ~0.2 ~ 2 0.1 2 0.1 60
playsound minecraft:item.mace.smash_ground player @a ~ ~ ~ 1.2 0.5
playsound chaoshearts:titan_stoneskin player @a ~ ~ ~ 1 0.8
playsound minecraft:block.stone.place player @a ~ ~ ~ 1.5 0.5
function ch:api/fx/shake {s:2,t:5,r:7}
function ch:api/fx/screen {o:"titan",color:"#7A746A",in:1,stay:3,out:10}
scoreboard players set #ti_d ch.tmp 20
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6] at @s run function ch:kit/titan/skin/bind_one
return 1
