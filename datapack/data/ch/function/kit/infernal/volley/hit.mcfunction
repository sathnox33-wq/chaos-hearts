# A fireball struck: damage and ignite what it hit; Triple Threat counts hits per volley. The burst follows in end.
function ch:kit/infernal/pal_e
scoreboard players operation #i_dmg ch.tmp = @s ch.v2
scoreboard players operation #i_vid ch.tmp = @s ch.v3
scoreboard players operation #i_kind ch.tmp = @s ch.v4
scoreboard players set #i_ft ch.tmp 60
execute as @e[tag=ch.target] at @s run function ch:kit/infernal/volley/hit_one
