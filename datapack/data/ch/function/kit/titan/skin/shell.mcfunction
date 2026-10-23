# Up: Obsidian Shell. 2.5 s of Resistance IV, rooted in place; then the shell bursts outward.
scoreboard players set @s ch.titan.skm 1
scoreboard players set @s ch.titan.skin 50
scoreboard players set @s ch.titan.abs 0
effect give @s minecraft:resistance 3 3 true
attribute @s minecraft:movement_speed modifier add ch:titan_shell -1 add_multiplied_total
attribute @s minecraft:jump_strength modifier add ch:titan_shell -1 add_multiplied_total
attribute @s minecraft:knockback_resistance modifier add ch:titan_skin 1 add_value
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:2760509,s0:0.4,s1:2.8,t:6,life:50,spin:30,dy:0.0}
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16742954,s0:0.5,s1:4.0,t:8,life:50,spin:170,dy:0.0}
function ch:kit/titan/fx/converge
particle minecraft:block{block_state:"minecraft:obsidian"} ~ ~1 ~ 0.6 0.8 0.6 0.1 60
particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.8 0.6 0.05 30
playsound chaoshearts:titan_stoneskin player @a ~ ~ ~ 1.2 0.6
playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 1 0.5
playsound minecraft:block.anvil.place player @a ~ ~ ~ 0.8 0.5
function ch:api/fx/screen {o:"titan",color:"#2A1F3D",in:2,stay:40,out:10}
return 1
