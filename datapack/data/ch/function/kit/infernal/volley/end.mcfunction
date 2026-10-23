# A fireball burst: layered explosion; meteors and mortar shells also blast the area around them.
function ch:kit/infernal/pal_e
scoreboard players set #i_own ch.tmp 0
execute unless entity @a[tag=ch.caster,limit=1] run scoreboard players set #i_own ch.tmp 1
execute if score #i_own ch.tmp matches 1 run function ch:api/tag_owner
scoreboard players operation #i_dmg ch.tmp = @s ch.v2
execute if score @s ch.v4 matches 1 run function ch:kit/infernal/volley/meteor_boom with storage ch:tmp ki
execute if score @s ch.v4 matches 2 run function ch:kit/infernal/volley/shell_boom with storage ch:tmp ki
execute unless score @s ch.v4 matches 1..2 run function ch:kit/infernal/volley/pop with storage ch:tmp ki
execute if score #i_own ch.tmp matches 1 run tag @a remove ch.caster
