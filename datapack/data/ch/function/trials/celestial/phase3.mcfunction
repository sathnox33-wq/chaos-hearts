# Phase 3: the firmament falls. Astrael grows brighter, the barrage thickens and the Supernova comes.
attribute @s minecraft:attack_damage base set 12
attribute @s minecraft:scale base set 3.2
function ch:trials/celestial/callout {m:"THE FIRMAMENT FALLS. Find cover!"}
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 1 1.4
execute positioned ~ ~1.5 ~ run function ch:api/fx/orb {color:16763210,s:10.0,t:4,life:10}
function ch:api/fx/wave {color:16777215,r:24,t:16}
scoreboard players set @s ch.celestial.tb2 60
scoreboard players set @s ch.v1 40
