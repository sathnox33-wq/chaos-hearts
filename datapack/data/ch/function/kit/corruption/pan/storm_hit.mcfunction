# Later: the glob lands - 4 damage within 1.8 blocks, Poison II, a small cloud and a green column of rain.
scoreboard players set #cd ch.tmp 40
scoreboard players operation #cnec ch.tmp = @s ch.v1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8,limit=6] run function ch:kit/corruption/pan/storm_victim
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8114490,w:0.7,h:9.0,t:2,life:7}
particle minecraft:item_slime ~ ~0.3 ~ 0.5 0.2 0.5 0.15 16
particle minecraft:dust{color:[0.784,0.831,0.165],scale:1.8} ~ ~0.4 ~ 0.6 0.3 0.6 0 16
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:2.5,t:4}
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 1 0.5
playsound chaoshearts:corruption_bolt player @a ~ ~ ~ 0.6 1.3
scoreboard players set #crad ch.tmp 18
scoreboard players set #clife ch.tmp 30
scoreboard players set #camp ch.tmp 0
scoreboard players set #cwit ch.tmp 0
execute positioned ~ ~0.5 ~ run function ch:kit/corruption/cloud/spawn
