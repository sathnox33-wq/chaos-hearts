# Caught in Judgement's detonation.
execute store result score #ce_ok ch.tmp run function ch:kit/celestial/hit
execute unless score #ce_ok ch.tmp matches 1.. run return 0
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.9,h:8.0,t:2,life:8}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"flash",color:"#FFF2B0",in:1,stay:3,out:12}
