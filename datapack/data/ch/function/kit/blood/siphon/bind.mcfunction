# A Siphon target is bound to the caster.
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
tag @s add ch.blood.sipt
tag @s add ch.blood.sipnew
scoreboard players operation @s ch.blood.so = #me ch.tmp
execute at @s run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.2 16
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#5A0010",in:2,stay:10,out:14}
execute if entity @s[type=player] run playsound minecraft:entity.elder_guardian.curse player @s ~ ~ ~ 0.4 1.6
