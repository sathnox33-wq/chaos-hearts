# During Ascension: hover after the rise, wings and halo of light, and the stars (or pillars) striking foes.
scoreboard players remove @s ch.celestial.asc 1
scoreboard players add @s ch.celestial.age 1
execute if score @s ch.celestial.age matches 18 if score @s ch.celestial.ascm matches 0 run function ch:kit/celestial/asc/hover
execute if score @s ch.celestial.age matches 32 if score @s ch.celestial.ascm matches 1 run function ch:kit/celestial/asc/hover
execute unless score @s ch.celestial.ascm matches 2 run function ch:kit/celestial/fx/wings
execute if score #ce_t4 ch.tmp matches 0 run particle minecraft:end_rod ~ ~1 ~ 0.4 0.6 0.4 0.01 2
execute if score #ce_t4 ch.tmp matches 2 positioned ~ ~2.2 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.949,0.69],scale:0.7}",r:0.4}
scoreboard players operation #ce_m ch.tmp = @s ch.celestial.age
scoreboard players operation #ce_m ch.tmp %= #10 ch.g
execute if score @s ch.celestial.ascm matches 0 if score #ce_m ch.tmp matches 0 if score @s ch.celestial.age matches 10.. run function ch:kit/celestial/asc/strike
scoreboard players operation #ce_m ch.tmp = @s ch.celestial.age
scoreboard players operation #ce_m ch.tmp %= #8 ch.celestial.k
execute if score @s ch.celestial.ascm matches 1 if score #ce_m ch.tmp matches 0 if score @s ch.celestial.age matches 16.. run function ch:kit/celestial/asc/zenith
scoreboard players operation #ce_m ch.tmp = @s ch.celestial.age
scoreboard players operation #ce_m ch.tmp %= #20 ch.g
execute if score @s ch.celestial.ascm matches 2 if score #ce_m ch.tmp matches 0 run function ch:kit/celestial/asc/avatar
execute if score @s ch.celestial.asc matches 40 run function ch:core/msg/say {m:"Ascension fading...",c:"#FFF2B0"}
execute if score @s ch.celestial.asc matches 0 run function ch:kit/celestial/asc/end
