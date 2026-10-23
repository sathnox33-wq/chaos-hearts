# Eruption, level: the marked spot (22 blocks) erupts 20 ticks later; radius 3.5 (4.6 with Magma Surge).
data modify storage ch:tmp ki merge value {r:3.5,dia:7.0,rh:1.6,d:80}
execute if score @s ch.b2 matches 4.. run data modify storage ch:tmp ki merge value {r:4.6,dia:9.2,rh:2.1}
function ch:api/ray {range:22}
tag @e[tag=ch.target] remove ch.target
execute at @e[type=marker,tag=ch.rayend,limit=1,sort=nearest] run summon minecraft:marker ~ ~ ~ {Tags:["ch.infernal.gm","ch.noability"]}
scoreboard players set #i_sn ch.tmp 10
execute as @e[type=marker,tag=ch.infernal.gm,limit=1] at @s run function ch:kit/infernal/gs
execute at @e[type=marker,tag=ch.infernal.gm,limit=1] align y run function ch:kit/infernal/erupt/mark with storage ch:tmp ki
kill @e[type=marker,tag=ch.infernal.gm]
execute anchored eyes run particle minecraft:flame ^ ^ ^1 0.1 0.1 0.1 0.05 10
playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 0.8 0.6
return 1
