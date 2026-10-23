# War Cry windup: the air is pulled in.
effect give @s minecraft:slowness 1 1 true
execute positioned ~ ~0.15 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:14689835,s0:16.0,s1:0.5,t:8,life:9,spin:-120,dy:0.0}
execute positioned ~ ~1.2 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:3801088,s0:4.0,s1:0.4,t:8,life:9,spin:170,dy:0.0}
particle minecraft:reverse_portal ~ ~1 ~ 2.5 1 2.5 0.02 60
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.4} ~ ~1 ~ 3 0.6 3 0 30
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1.2 0.8
playsound minecraft:entity.ravager.ambient player @a ~ ~ ~ 1 0.6
function ch:api/later {t:8,then:"ch:kit/rage/cry/roar_l"}
return 1
