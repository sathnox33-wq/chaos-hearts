# As the Open Veins marker: finds the target again and tears the wound.
scoreboard players operation #e ch.tmp = @s ch.v1
execute store result storage ch:tmp blood.d int 1 run scoreboard players get @s ch.v2
execute as @e[type=!#ch:ignore,tag=!ch.caster,distance=..16] if score @s ch.eid = #e ch.tmp at @s run function ch:kit/blood/veins_hit with storage ch:tmp blood
