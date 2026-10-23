# The sanctuary shatters.
kill @e[type=item_display,tag=ch.celestial.bdome,distance=..20]
execute positioned ~ ~1.5 ~ run function ch:api/fx/orb {color:12576511,s:7.0,t:3,life:6}
particle minecraft:end_rod ~ ~1.5 ~ 1 1 1 0.5 80
playsound minecraft:block.glass.break master @a ~ ~ ~ 2 1.2
function ch:trials/celestial/callout {m:"The sanctuary shatters! Strike now!"}
