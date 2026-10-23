# Undying Rage (Juggernaut capstone): falling to 3 hearts or less refuses death once every 2 minutes and starts a short Rampage.
scoreboard players set @s ch.rage.und 2400
effect give @s minecraft:resistance 2 4 true
effect give @s minecraft:regeneration 4 2 true
effect give @s minecraft:absorption 10 0 true
scoreboard players set @s ch.rage.rv 0
function ch:kit/rage/rampage/begin {t:80}
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.8 0.5 0.6 80
particle minecraft:dust{color:[0.88,0.15,0.17],scale:2.0} ~ ~1 ~ 1.2 1.2 1.2 0 80
particle minecraft:soul_fire_flame ~ ~0.2 ~ 0.6 0.1 0.6 0.08 30
function ch:api/fx/wave {color:14689835,r:6.0,t:8}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:14689835,s:4.0,t:4,life:10}
execute positioned ~ ~1.1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"crack",color:16738847,s0:0.5,s1:4.0,t:4,life:16,spin:0,dy:0.0}
function ch:api/fx/screen {o:"awaken",color:"#E0262B",in:0,stay:6,out:16}
function ch:api/fx/shake {s:3,t:12,r:10}
function ch:api/fx/text {text:"UNDYING RAGE",color:"#FF3030"}
playsound minecraft:item.totem.use player @a ~ ~ ~ 1 0.6
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1 0.7
playsound chaoshearts:rage_rampage player @a ~ ~ ~ 1.2 1.2
