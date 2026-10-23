# The fist meets the ground: shockwave, crater crack, debris, light, shake and the slam's layered sound.
function ch:api/fx/wave {color:13214812,r:3.5,t:6}
execute positioned ~ ~0.04 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.5,s1:3.4,t:3,life:40,spin:0,dy:0.0}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:13214812,s0:0.4,s1:2.6,t:5,life:14,spin:90,dy:0.0}
function ch:kit/titan/fx/debris
particle minecraft:dust{color:[0.478,0.455,0.416],scale:2.0} ~ ~0.2 ~ 1.2 0.1 1.2 0 30
particle minecraft:explosion ~ ~0.3 ~ 0.6 0.1 0.6 0 3
particle minecraft:campfire_cosy_smoke ~ ~0.3 ~ 0.9 0.1 0.9 0.02 8
playsound chaoshearts:titan_slam player @a ~ ~ ~ 1.3 1
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.2 0.6
playsound minecraft:entity.iron_golem.attack player @a ~ ~ ~ 1 0.5
function ch:api/fx/shake {s:2,t:6,r:8}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
execute if score #ti_cat ch.tmp matches 0 run function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:2,out:8}
execute if score #ti_cat ch.tmp matches 1 run function ch:kit/titan/slam/cat_fx
