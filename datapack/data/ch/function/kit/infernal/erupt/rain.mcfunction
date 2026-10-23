# Eruption, up: molten bombs are called from the sky onto the 5 nearest foes (18 blocks) or ahead of you; dodge the circles.
data modify storage ch:tmp ki merge value {r:2.4,dia:4.8,rh:1.1,d:70}
scoreboard players set #i_rn ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..18,limit=5,sort=nearest] at @s run function ch:kit/infernal/erupt/rain_mark
execute if score #i_rn ch.tmp matches 0 rotated ~ 0 positioned ^ ^ ^7 run function ch:kit/infernal/erupt/rain_mark
execute if score #i_rn ch.tmp matches 1 rotated ~ 0 positioned ^-3 ^ ^10 run function ch:kit/infernal/erupt/rain_mark
execute if score #i_rn ch.tmp matches 2 rotated ~ 0 positioned ^3 ^ ^10 run function ch:kit/infernal/erupt/rain_mark
function ch:kit/infernal/erupt/rain_fx with storage ch:tmp ki
return 1
