# Hits everything within $(r) blocks of the impact.
scoreboard players set #hits ch.tmp 0
$execute positioned ~ ~0.8 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] run function ch:kit/celestial/star/hurt
