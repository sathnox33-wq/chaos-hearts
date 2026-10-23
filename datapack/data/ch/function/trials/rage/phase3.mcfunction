# Phase 3, Bloodrage: faster, stronger, black fire on his back, charges twice, the pit's edge turns to magma.
attribute @s minecraft:movement_speed base set 0.38
attribute @s minecraft:scale base set 1.85
effect give @s minecraft:strength infinite 1 true
scoreboard players set @s ch.v4 30
execute on passengers if entity @s[tag=ch.rage.halo] run data modify entity @s item.components."minecraft:custom_model_data" set value {colors:[1114112]}
execute on passengers if entity @s[tag=ch.rage.flame] run data modify entity @s item.components."minecraft:custom_model_data" set value {colors:[3801088]}
execute as @e[type=marker,tag=ch.session,distance=..80,limit=1] at @s run function ch:trials/rage/edge_magma
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:soul_fire_flame ~ ~2 ~ 2 2 2 0.1 80
function ch:api/fx/wave {color:1114112,r:16.0,t:12}
function ch:api/fx/shake {s:3,t:20,r:60}
playsound minecraft:entity.ender_dragon.growl master @a[distance=..90] ~ ~ ~ 2 0.5
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 3 0.4
function ch:trials/rage/say {m:"BLOODRAGE. Gorrath will not stop now."}
execute as @a[tag=ch.challenger,distance=..90] run function ch:api/fx/screen {o:"rage",color:"#5A0A0A",in:2,stay:10,out:20}
