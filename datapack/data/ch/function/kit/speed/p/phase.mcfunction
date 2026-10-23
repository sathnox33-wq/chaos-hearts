# Phase Runner: during Slipstream one blow in four passes through your afterimage (the health comes back).
execute store result score #r ch.speed.g run random value 1..4
execute unless score #r ch.speed.g matches 1 run return 0
execute store result score #hn ch.speed.g run data get entity @s Health 1
execute if score #hn ch.speed.g matches ..0 run return 0
scoreboard players operation #lost ch.speed.g = @s ch.speed.hp
scoreboard players operation #lost ch.speed.g -= #hn ch.speed.g
execute if score #lost ch.speed.g matches ..0 run return 0
execute store result storage ch:kspeed hl.n int 1 run scoreboard players get #lost ch.speed.g
function ch:api/heal with storage ch:kspeed hl
function ch:api/fx/text {text:"PHASED",color:"#29D3F2"}
particle minecraft:dust{color:[0.16,0.83,0.95],scale:1.2} ~ ~1 ~ 0.4 0.6 0.4 0 16
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring_soft",color:2741234,s0:1.8,s1:0.2,t:4,life:6,spin:0,dy:0.0}
playsound minecraft:entity.enderman.teleport player @a ~ ~ ~ 0.4 2
