# Blood Moon running, as the caster: the moon follows (or holds its place), blood rains, enemies bleed each second.
scoreboard players remove @s ch.blood.moon 1
execute if score @s ch.blood.mv matches 0 as @e[type=item_display,tag=ch.blood.morb,distance=..40] if score @s ch.owner = #me ch.tmp run tp @s ~ ~9 ~
execute as @e[tag=ch.blood.moonv,distance=..80] if score @s ch.owner = #me ch.tmp run scoreboard players set @s ch.life 6
execute if score @s ch.blood.mv matches 0 run function ch:kit/blood/moon/around
execute if score @s ch.blood.mv matches 1 as @e[type=marker,tag=ch.blood.moonv,distance=..80] if score @s ch.owner = #me ch.tmp at @s run function ch:kit/blood/moon/eclipse
execute if score @s ch.blood.moon matches ..0 run function ch:kit/blood/moon/set
