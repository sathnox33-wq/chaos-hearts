# Judgement: every second enemies inside (radius $(r)) burn for 1.5; the last 15 ticks blaze as a warning, then it detonates.
scoreboard players operation #ce_m ch.tmp = @s ch.v4
scoreboard players operation #ce_m ch.tmp %= #20 ch.g
execute if score @s ch.life matches 15 run playsound minecraft:block.beacon.deactivate player @a ~ ~ ~ 1.4 1.6
execute if score @s ch.life matches 15 run playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 1 1.4
$execute if score @s ch.life matches ..15 run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.79,0.29],scale:2.0}",r:$(r)}
$execute if score @s ch.life matches ..15 run particle minecraft:end_rod ~ ~0.3 ~ $(r) 0.1 $(r) 0.02 6
$execute if score @s ch.life matches 0 run function ch:kit/celestial/sanc/detonate {r:$(r)}
execute unless score #ce_m ch.tmp matches 0 run return 0
$function ch:kit/celestial/sanc/sides {r:$(r)}
scoreboard players set #ce_d ch.tmp 15
execute as @e[tag=ch.celestial.en] at @s run function ch:kit/celestial/sanc/burn
tag @a remove ch.celestial.al
tag @e[tag=ch.celestial.en] remove ch.celestial.en
