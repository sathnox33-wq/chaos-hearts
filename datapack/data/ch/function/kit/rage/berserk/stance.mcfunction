# Retaliation (Berserk Chain, looking up): plant yourself for 5 s. Knockback barely moves you, and up to 4 blows you
# take (one per 8 ticks) erupt back at everyone within 3.5 for 4 damage plus a quarter of your Fury.
function ch:kit/rage/berserk/end
scoreboard players set @s ch.rage.bzm 1
scoreboard players set @s ch.rage.bz 4
scoreboard players set @s ch.rage.bzt 100
attribute @s minecraft:knockback_resistance modifier add ch:rage_stance 0.8 add_value
function ch:api/fx/sprite {model:"dome",color:14689835,s0:0.5,s1:3.0,t:4,life:10,spin:90,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:14689835,s0:0.5,s1:4.0,t:5,life:100,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ run function ch:api/fx/sprite3 {model:"spike",color:3801088,a:"[0.3,0.05,0.3]",b:"[0.9,1.8,0.9]",t:3,life:12,spin:45}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.6} ~ ~1 ~ 0.8 0.8 0.8 0 30
function ch:api/fx/text {text:"RETALIATION",color:"#E0262B"}
playsound minecraft:block.anvil.place player @a ~ ~ ~ 0.7 0.5
playsound chaoshearts:rage_berserk player @a ~ ~ ~ 0.9 0.7
playsound minecraft:entity.iron_golem.repair player @a ~ ~ ~ 0.8 0.6
return 1
