# Slipstream. Level: Speed III, your wake slows. Up: Afterburner, rocket along your look and your wake burns.
# Down: Vortex Lap, a cyclone circles you, drags enemies into orbit and flings them out when it ends.
scoreboard players operation @s ch.speed.smode = #var ch.tmp
execute if score #var ch.tmp matches 0 run scoreboard players set @s ch.speed.slip 120
execute if score #var ch.tmp matches 0 run effect give @s minecraft:speed 6 2 true
execute if score #var ch.tmp matches 0 run effect give @s minecraft:haste 6 1 true
execute if score #var ch.tmp matches 1 run scoreboard players set @s ch.speed.slip 80
execute if score #var ch.tmp matches 1 run effect give @s minecraft:speed 4 2 true
execute if score #var ch.tmp matches 1 run effect give @s minecraft:slow_falling 2 0 true
execute if score #var ch.tmp matches 1 run function ch:api/leap {n:2}
execute if score #var ch.tmp matches 2 run scoreboard players set @s ch.speed.slip 60
execute if score #var ch.tmp matches 2 run effect give @s minecraft:speed 3 1 true
execute store result score @s ch.speed.px run data get entity @s Pos[0] 100
execute store result score @s ch.speed.pz run data get entity @s Pos[2] 100
execute store result score @s ch.speed.hp run data get entity @s Health 1
function ch:api/fx/wave {color:16113986,r:5.0,t:8}
execute positioned ~ ~0.2 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"swirl",color:2741234,s0:0.5,s1:4.5,t:6,life:10,spin:170,dy:0.0}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:0.3,s1:3.0,t:3,life:6,spin:0,dy:0.0}
particle minecraft:gust_emitter_small ~ ~0.5 ~ 0 0 0 0 1
particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~0.5 ~ 1.2 0.3 1.2 0 40
playsound chaoshearts:speed_slipstream player @a ~ ~ ~ 1 1
playsound minecraft:entity.breeze.charge player @a ~ ~ ~ 1 1.5
playsound minecraft:item.trident.riptide_3 player @a ~ ~ ~ 0.6 1.6
function ch:api/fx/screen {o:"speed",color:"#F5E142",in:1,stay:4,out:10}
execute if score #var ch.tmp matches 1 run title @s subtitle {text:"Afterburner",color:"#FF9A3C",italic:true}
execute if score #var ch.tmp matches 2 run title @s subtitle {text:"Vortex Lap",color:"#29D3F2",italic:true}
execute if score #var ch.tmp matches 2 positioned ~ ~0.3 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:16113986,s0:8.0,s1:9.0,t:60,life:60,spin:170,dy:0.0}
return 1
