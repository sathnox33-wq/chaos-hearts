# Rampage entrance: a blast that throws back everyone close, a swelling dark sun, a skull rising in fire.
tag @s add ch.caster
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4] run function ch:api/push {s:0.9,y:0.35}
tag @s remove ch.caster
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
function ch:api/fx/wave {color:14689835,r:7.0,t:7}
execute unless score @s ch.rage.rv matches 2 run function ch:api/fx/pillar {model:"beam",color:14689835,w:1.6,h:12.0,t:4,life:14}
execute if score @s ch.rage.rv matches 2 run function ch:api/fx/pillar {model:"beam",color:1114112,w:1.8,h:12.0,t:4,life:14}
function ch:api/fx/pillar {model:"flame",color:16738847,w:2.4,h:5.0,t:3,life:12}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:3801088,s:4.5,t:4,life:8}
execute positioned ~ ~3.5 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"skull",color:14689835,s0:0.5,s1:3.0,t:6,life:22,spin:0,dy:1.5}
particle minecraft:flame ~ ~1 ~ 0.5 2 0.5 0.06 60
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.5} ~ ~1 ~ 2 1 2 0 60
function ch:api/fx/shake {s:3,t:14,r:16}
function ch:api/fx/screen {o:"rage",color:"#E0262B",in:1,stay:8,out:16}
execute unless score @s ch.rage.rv matches 2 run function ch:api/fx/text {text:"R A M P A G E",color:"#E0262B"}
execute if score @s ch.rage.rv matches 2 run function ch:api/fx/text {text:"BLOOD FOR BLOOD",color:"#8A0000"}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:12}
playsound chaoshearts:rage_rampage player @a ~ ~ ~ 1.6 1
playsound minecraft:entity.ender_dragon.growl player @a ~ ~ ~ 0.9 1.3
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1 0.6
execute as @a[distance=0.01..12] run function ch:kit/rage/rampage/dread
function ch:api/later {t:3,then:"ch:kit/rage/rampage/entrance2"}
function ch:api/later {t:7,then:"ch:kit/rage/rampage/entrance3"}
