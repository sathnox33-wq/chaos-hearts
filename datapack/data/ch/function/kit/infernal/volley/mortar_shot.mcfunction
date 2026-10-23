# As the caster: lobs mortar shell #i_k of #i_n.
execute unless score @s ch.active matches 3 run return 0
function ch:kit/infernal/pal
scoreboard players operation #i_last ch.tmp = #i_n ch.tmp
scoreboard players remove #i_last ch.tmp 1
scoreboard players set #i_kind ch.tmp 2
scoreboard players set #i_dmg ch.tmp 40
execute if score #i_k ch.tmp = #i_last ch.tmp if score @s ch.b1 matches 5.. run scoreboard players set #i_kind ch.tmp 1
execute if score @s ch.b1 matches 1.. run function ch:kit/infernal/mul_dmg
function ch:kit/infernal/volley/launch
tag @e[type=item_display,tag=ch.infernal.np] add ch.infernal.arc
execute as @e[type=item_display,tag=ch.infernal.np,limit=1] at @s run function ch:kit/infernal/volley/mortar_yaw
function ch:kit/infernal/volley/done
function ch:kit/infernal/volley/muzzle with storage ch:tmp ki
playsound minecraft:entity.firework_rocket.launch player @a ~ ~ ~ 0.8 0.6
