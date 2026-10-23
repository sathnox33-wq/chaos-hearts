# The Phoenix explosion: wings of fire, a sun-bright flash and a blast that burns and hurls everything around.
function ch:kit/infernal/pal
function ch:kit/infernal/phoenix_fx with storage ch:tmp ki
scoreboard players set #i_dmg ch.tmp 80
scoreboard players set #i_ft ch.tmp 100
execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.5] run function ch:kit/infernal/erupt/boom_one
