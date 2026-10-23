# As something caught by the fracture for the first time: time grips it.
tag @s add ch.speed.fz
scoreboard players set @s ch.speed.debt 0
scoreboard players add @e[type=marker,tag=ch.speed.fcur,limit=1] ch.v4 1
function ch:api/cc with storage ch:kspeed fcc
execute positioned ~ ~2.3 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:2741234,s0:0.1,s1:0.9,t:4,life:24,spin:170,dy:0.0}
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.05 20
playsound minecraft:block.bell.use player @a ~ ~ ~ 0.6 0.5
execute if entity @s[type=player] run function ch:api/fx/screen {o:"speed",color:"#29D3F2",in:2,stay:20,out:20}
