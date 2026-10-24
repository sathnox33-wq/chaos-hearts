# Panel: heals, feeds and clears negative effects on the picked player.
effect clear @a[tag=ch.adtgt]
effect give @a[tag=ch.adtgt] minecraft:instant_health 1 20 true
effect give @a[tag=ch.adtgt] minecraft:saturation 1 20 true
tellraw @s {text:"Healed and fed.",color:"gray"}
