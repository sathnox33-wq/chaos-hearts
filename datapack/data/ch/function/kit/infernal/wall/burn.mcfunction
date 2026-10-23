# Every half second: burns enemies in the segment; Cinder Shield gives its owner Resistance I nearby.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
function ch:kit/infernal/pal_e
scoreboard players set #i_dmg ch.tmp 20
scoreboard players set #i_ft ch.tmp 80
execute positioned ~ ~0.6 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.5] at @s run function ch:kit/infernal/sear
execute if score @s ch.v5 matches 1 run effect give @a[tag=ch.caster,distance=..3.5,limit=1] minecraft:resistance 1 0 true
execute if score #t20 ch.g matches 0 run playsound minecraft:block.fire.ambient block @a ~ ~ ~ 0.7 0.8
