# Once a second: Starlit (night vision, regeneration under the open daytime sky) and Starlight trickling in.
scoreboard players operation #ce_m ch.tmp = #now ch.g
scoreboard players operation #ce_m ch.tmp %= #200 ch.celestial.k
execute if score #ce_m ch.tmp matches 0 run effect give @s minecraft:night_vision 30 0 true
execute store result score #ce_tod ch.tmp run time query daytime
execute if score #ce_tod ch.tmp matches 0..12300 if predicate {condition:"minecraft:location_check",predicate:{can_see_sky:true}} run function ch:kit/celestial/passive/sun
execute unless score #ce_tod ch.tmp matches 0..12300 if predicate {condition:"minecraft:location_check",predicate:{can_see_sky:true}} run scoreboard players add @s ch.celestial.sl 2
scoreboard players add @s ch.celestial.sl 1
