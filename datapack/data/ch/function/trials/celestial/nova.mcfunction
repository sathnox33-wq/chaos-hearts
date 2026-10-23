# Supernova (phase 3): Astrael rises over the centre and gathers light for 3.5 s. Hide behind a pillar!
scoreboard players set @s ch.celestial.tb2 320
scoreboard players set @s ch.celestial.tb3 70
data merge entity @s {NoAI:1b}
function ch:trials/celestial/callout {m:"SUPERNOVA! Hide behind a pillar!"}
playsound minecraft:block.beacon.activate master @a ~ ~ ~ 3 0.5
playsound chaoshearts:celestial_supernova master @a ~ ~ ~ 2 0.6
