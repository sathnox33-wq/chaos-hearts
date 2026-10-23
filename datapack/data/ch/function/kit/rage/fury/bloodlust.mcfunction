# Bloodlust (mastery 25): full Fury grants Strength I for 6 seconds (10 s internal cooldown).
scoreboard players set @s ch.rage.bl 200
effect give @s minecraft:strength 6 0
function ch:api/fx/wave {color:14689835,r:5.0,t:8}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:3801088,s:2.6,t:5,life:9}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16738847,s0:0.4,s1:3.5,t:6,life:10,spin:90,dy:0.0}
function ch:api/fx/text {text:"BLOODLUST",color:"#E0262B"}
function ch:api/fx/screen {o:"rage",color:"#E0262B",in:1,stay:4,out:12}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.0} ~ ~1 ~ 0.6 0.8 0.6 0 40
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.5 ~ 0.6 0.4 0.6 0 20
playsound chaoshearts:rage_bloodlust player @a ~ ~ ~ 1.2 1
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 0.7 1.4
