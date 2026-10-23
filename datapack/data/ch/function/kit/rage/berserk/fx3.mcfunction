# Final link: the shatter. A column of fire, a stun and a camera hit.
function ch:api/stun {t:15}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:14689835,r:4.0,t:6}
execute positioned ~ ~0.06 ~ rotated ~30 0 run function ch:api/fx/sprite {model:"crack",color:16738847,s0:0.5,s1:6.0,t:2,life:30,spin:0,dy:0.0}
function ch:api/fx/pillar {model:"flame",color:16738847,w:1.6,h:4.5,t:2,life:8}
function ch:api/fx/pillar {model:"beam",color:14689835,w:0.8,h:7.0,t:2,life:8}
particle minecraft:explosion ~ ~1 ~ 0.3 0.3 0.3 0 2
particle minecraft:lava ~ ~0.5 ~ 0.6 0.2 0.6 0 8
function ch:api/fx/shake {s:2,t:7,r:8}
function ch:api/fx/text {text:"SHATTER",color:"#FF3030"}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#E0262B",in:0,stay:3,out:10}
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1 0.9
playsound minecraft:block.anvil.land player @a ~ ~ ~ 0.5 0.7
playsound chaoshearts:rage_berserk player @a ~ ~ ~ 1 1.3
