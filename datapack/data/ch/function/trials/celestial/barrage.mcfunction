# Starfall barrage: sigils bloom under and around the challenger; 28 ticks later the stars hit them.
scoreboard players set @s ch.v1 120
function ch:trials/celestial/callout {m:"Astrael calls the stars down! Leave the glowing circles."}
playsound minecraft:block.beacon.power_select master @a ~ ~ ~ 2 1.4
execute at @a[tag=ch.challenger,limit=1] run function ch:trials/celestial/sf_mark
function ch:api/later {t:3,then:"ch:trials/celestial/sf_rand"}
function ch:api/later {t:6,then:"ch:trials/celestial/sf_rand"}
function ch:api/later {t:9,then:"ch:trials/celestial/sf_rand"}
function ch:api/later {t:12,then:"ch:trials/celestial/sf_rand"}
function ch:api/later {t:15,then:"ch:trials/celestial/sf_rand"}
execute if score @s ch.phase matches 3.. run function ch:api/later {t:18,then:"ch:trials/celestial/sf_rand"}
execute if score @s ch.phase matches 3.. run function ch:api/later {t:21,then:"ch:trials/celestial/sf_rand"}
execute if score @s ch.phase matches 3.. run function ch:api/later {t:24,then:"ch:trials/celestial/sf_rand"}
