# Searing (mastery 25): melee hits set the victim alight (twice as long with Kindling) and build Heat.
execute unless score @s ch.lvl matches 25.. run return 0
scoreboard players set #i_ft ch.tmp 60
execute if score @s ch.b3 matches 1.. run scoreboard players set #i_ft ch.tmp 120
execute as @e[tag=ch.victim,limit=1] at @s run function ch:kit/infernal/sear_melee
scoreboard players set #i_hg ch.tmp 4
function ch:kit/infernal/heat
