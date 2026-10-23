# Blood melee: a thread of blood flows back to you, Hemorrhage on critical hits, Open Veins on bleeding targets.
scoreboard players set #ln ch.tmp 12
execute as @e[tag=ch.victim,limit=1] at @s positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/blood/fx/line
scoreboard players set #crit ch.tmp 0
execute if predicate {condition:"minecraft:entity_properties",entity:"this",predicate:{flags:{is_on_ground:false},movement:{fall_distance:{min:0.01}}}} run scoreboard players set #crit ch.tmp 1
execute if score @s ch.lvl matches 25.. if score #crit ch.tmp matches 1 as @e[tag=ch.victim,limit=1] at @s run function ch:kit/blood/hemorrhage
execute if score @s ch.b2 matches 3.. as @e[tag=ch.victim,limit=1,scores={ch.blood.bleed=1..}] at @s run function ch:kit/blood/veins
