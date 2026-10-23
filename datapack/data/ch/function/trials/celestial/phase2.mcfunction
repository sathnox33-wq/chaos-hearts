# Phase 2: Astrael splits its light; the pillars blaze, two Starlings join, it learns the Dive and the Sanctuary.
function ch:trials/celestial/callout {m:"Astrael's light splits! The firmament stirs."}
playsound chaoshearts:celestial_ascension master @a ~ ~ ~ 2 0.6
execute at @e[type=marker,tag=ch.session,distance=..80,limit=1] run function ch:trials/celestial/pillar_light
execute positioned ~2 ~ ~ summon minecraft:vex run function ch:trials/celestial/mob_starling
execute positioned ~-2 ~ ~ summon minecraft:vex run function ch:trials/celestial/mob_starling
scoreboard players set @s ch.v3 60
scoreboard players set @s ch.celestial.tb1 120
