# Every half second: enemies within 2.5 blocks of the orb take its damage.
scoreboard players operation #vd ch.tmp = @s ch.v4
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.5,limit=10] run function ch:kit/void/hurt
playsound minecraft:block.respawn_anchor.ambient player @a ~ ~ ~ 0.6 1.5
