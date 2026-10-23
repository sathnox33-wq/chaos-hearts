# Crimson Eclipse pulse (as the anchor, owner tagged): bleed and darkness inside; the owner's 40% lifesteal works only inside.
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players set #bt ch.tmp 30
scoreboard players set #bm ch.tmp 1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..14] run function ch:kit/blood/moon/eclipse_one
function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.18,0.25],scale:1.4}",r:14}
tag @a remove ch.caster
