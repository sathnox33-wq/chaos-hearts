# Panel: clears the picked player's ability and shuffle cooldowns.
scoreboard players set @a[tag=ch.adtgt] ch.cd1 0
scoreboard players set @a[tag=ch.adtgt] ch.cd2 0
scoreboard players set @a[tag=ch.adtgt] ch.cd3 0
scoreboard players set @a[tag=ch.adtgt] ch.cd4 0
scoreboard players set @a[tag=ch.adtgt] ch.swapcd 0
scoreboard players set @a[tag=ch.adtgt] ch.hud 5
tellraw @s {text:"Cooldowns reset.",color:"gray"}
