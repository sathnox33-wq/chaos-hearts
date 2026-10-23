# The sound of the strike catches up: a sonic boom on the marked entity, credited to whoever primed it.
tag @a remove ch.caster
scoreboard players operation #o ch.speed.g = @s ch.speed.bo
execute as @a if score @s ch.pid = #o ch.speed.g run tag @s add ch.caster
scoreboard players operation #d ch.speed.g = @s ch.speed.bd
function ch:kit/speed/fn/hit
particle minecraft:sonic_boom ~ ~1 ~ 0 0 0 0 1
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 0.5 0.5 0.5 0 20
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:0.4,s1:4.0,t:3,life:6,spin:0,dy:0.0}
execute positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"ring_soft",color:16113986,s0:0.4,s1:3.2,t:4,life:7,spin:0,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:3}
playsound minecraft:entity.firework_rocket.blast player @a ~ ~ ~ 1.2 0.7
playsound minecraft:entity.breeze.wind_burst player @a ~ ~ ~ 1 1.4
function ch:api/fx/shake {s:2,t:5,r:4}
tag @a remove ch.caster
