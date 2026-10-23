# Aegis: every 4 ticks enemies inside radius $(r) are thrown out of the dome.
scoreboard players operation #ce_m ch.tmp = @s ch.v4
scoreboard players operation #ce_m ch.tmp %= #4 ch.g
execute unless score #ce_m ch.tmp matches 0 run return 0
$function ch:kit/celestial/sanc/sides {r:$(r)}
execute as @e[tag=ch.celestial.en] at @s run function ch:kit/celestial/sanc/repel
tag @a remove ch.celestial.al
tag @e[tag=ch.celestial.en] remove ch.celestial.en
