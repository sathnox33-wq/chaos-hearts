# Down: the mire erupts - grasping roots root everything on it for 1.5 s and tear for 5 damage.
scoreboard players operation #cnec ch.tmp = @s ch.v6
scoreboard players set #cd ch.tmp 50
execute store result score #cry ch.tmp run data get entity @s Pos[1] 10
execute if score @s ch.v2 matches ..55 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5,limit=16] run function ch:kit/corruption/rot/root
execute if score @s ch.v2 matches 56.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6.5,limit=16] run function ch:kit/corruption/rot/root
playsound minecraft:entity.warden.emerge player @a ~ ~ ~ 1.2 1.3
playsound minecraft:block.rooted_dirt.break player @a ~ ~ ~ 1.5 0.5
playsound chaoshearts:corruption_spread player @a ~ ~ ~ 1 0.8
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.3 ~ 2.5 0.2 2.5 0 120
particle minecraft:dust{color:[0.122,0.227,0.055],scale:2.2} ~ ~0.8 ~ 2.5 0.6 2.5 0 50
execute positioned ^ ^ ^1.5 rotated ~ 0 run function ch:api/fx/sprite3 {model:"spike",color:2046478,a:"[0.6,0.1,0.6]",b:"[0.7,2.6,0.7]",t:3,life:30,spin:40}
execute rotated 0 0 positioned ^3 ^ ^1 run function ch:api/fx/sprite3 {model:"spike",color:4004434,a:"[0.5,0.1,0.5]",b:"[0.6,2.2,0.6]",t:3,life:28,spin:-60}
execute rotated 72 0 positioned ^2 ^ ^2.6 run function ch:api/fx/sprite3 {model:"spike",color:2046478,a:"[0.5,0.1,0.5]",b:"[0.8,3.0,0.8]",t:4,life:30,spin:30}
execute rotated 144 0 positioned ^-1 ^ ^3.4 run function ch:api/fx/sprite3 {model:"spike",color:8114490,a:"[0.4,0.1,0.4]",b:"[0.5,2.0,0.5]",t:3,life:26,spin:-40}
execute rotated 216 0 positioned ^2.5 ^ ^-1.5 run function ch:api/fx/sprite3 {model:"spike",color:2046478,a:"[0.6,0.1,0.6]",b:"[0.7,2.8,0.7]",t:4,life:30,spin:50}
execute rotated 288 0 positioned ^-3 ^ ^-2 run function ch:api/fx/sprite3 {model:"spike",color:4004434,a:"[0.5,0.1,0.5]",b:"[0.6,2.4,0.6]",t:3,life:28,spin:-30}
execute rotated 30 0 positioned ^ ^ ^-3.5 run function ch:api/fx/sprite3 {model:"spike",color:2046478,a:"[0.5,0.1,0.5]",b:"[0.7,2.6,0.7]",t:4,life:30,spin:20}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:5.5,t:5}
function ch:kit/corruption/rot/decal
function ch:api/fx/shake {s:2,t:8,r:10}
