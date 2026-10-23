# Blood world tick: bleeding entities, Blood Thorns, falling moons and the kit's persistent displays.
execute if score #bleeds ch.blood.g matches 1.. run function ch:kit/blood/bleed/all
execute if entity @e[type=marker,tag=ch.blood.thorn,limit=1] as @e[type=marker,tag=ch.blood.thorn] at @s run function ch:kit/blood/spike/thorn_step
execute if entity @e[type=item_display,tag=ch.blood.mfall,limit=1] as @e[type=item_display,tag=ch.blood.mfall] at @s run function ch:kit/blood/moon/fall_step
execute if entity @e[tag=ch.blood.deco,limit=1] as @e[tag=ch.blood.deco] run function ch:kit/blood/deco_tick
