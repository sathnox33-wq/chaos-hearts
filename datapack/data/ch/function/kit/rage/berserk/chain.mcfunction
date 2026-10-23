# Berserk Chain (level): bonus damage on the next hits.
function ch:kit/rage/berserk/end
scoreboard players set @s ch.rage.bz 3
execute if score @s ch.awake matches 1 run scoreboard players set @s ch.rage.bz 4
scoreboard players set @s ch.rage.bzt 120
scoreboard players set @s ch.rage.bzm 0
execute unless score @s ch.b1 matches 2.. run attribute @s minecraft:attack_damage modifier add ch:rage_berserk 3 add_value
execute if score @s ch.b1 matches 2.. run attribute @s minecraft:attack_damage modifier add ch:rage_berserk 3.75 add_value
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16738847,s0:0.5,s1:2.6,t:5,life:12,spin:170,dy:0.6}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:14689835,s:1.8,t:3,life:6}
particle minecraft:flame ~ ~1 ~ 0.4 0.5 0.4 0.05 20
particle minecraft:dust{color:[1.0,0.42,0.12],scale:1.2} ~ ~1 ~ 0.6 0.6 0.6 0 30
function ch:api/fx/screen {o:"rage",color:"#FF6A1F",in:0,stay:3,out:10}
function ch:api/fx/text {text:"BERSERK",color:"#FF6A1F"}
playsound minecraft:item.armor.equip_netherite player @a ~ ~ ~ 1 0.6
playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 0.5 0.6
playsound chaoshearts:rage_berserk player @a ~ ~ ~ 1 1
return 1
