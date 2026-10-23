# Radiant Beam: Astrael locks a line on the challenger, a guide of light shows it for 26 ticks, then it fires.
scoreboard players set @s ch.v2 180
scoreboard players set @s ch.v6 38
data merge entity @s {NoAI:1b}
function ch:trials/celestial/callout {m:"Astrael focuses a radiant beam! Get off the line."}
playsound minecraft:block.beacon.power_select master @a ~ ~ ~ 2 1.8
execute positioned ~ ~1.6 ~ facing entity @a[tag=ch.challenger,limit=1] eyes summon marker run function ch:trials/celestial/beam_init
