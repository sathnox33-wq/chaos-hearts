# Rewind, as the owner: back to where the fracture was cast, with the health lost since.
scoreboard players operation #o ch.speed.g = @s ch.pid
tag @e[type=marker,tag=ch.speed.atag] remove ch.speed.atag
execute as @e[type=marker,tag=ch.speed.anchor,distance=..64] if score @s ch.owner = #o ch.speed.g run tag @s add ch.speed.atag
execute unless entity @e[type=marker,tag=ch.speed.atag,limit=1] run return 0
particle minecraft:dust{color:[0.16,0.83,0.95],scale:1.2} ~ ~1 ~ 0.3 0.6 0.3 0 20
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:2741234,s0:2.4,s1:0.1,t:4,life:6,spin:0,dy:0.0}
execute at @e[type=marker,tag=ch.speed.atag,limit=1] run tp @s ~ ~ ~
execute store result score #hn ch.speed.g run data get entity @s Health 1
scoreboard players operation #lost ch.speed.g = #fh ch.speed.g
scoreboard players operation #lost ch.speed.g -= #hn ch.speed.g
execute if score #lost ch.speed.g matches 1.. store result storage ch:kspeed hl.n int 1 run scoreboard players get #lost ch.speed.g
execute if score #lost ch.speed.g matches 1.. run function ch:api/heal with storage ch:kspeed hl
kill @e[type=marker,tag=ch.speed.atag]
execute at @s positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:0.1,s1:3.0,t:4,life:7,spin:0,dy:0.0}
execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.4 0.8 0.4 0.4 50
execute at @s run playsound chaoshearts:speed_rewind player @a ~ ~ ~ 1 1
execute at @s run playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.8 0.6
function ch:api/fx/screen {o:"speed",color:"#29D3F2",in:0,stay:4,out:12}
