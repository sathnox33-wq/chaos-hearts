# Blood became the active heart: clears the stale damage counter and shows the Vitae meter.
scoreboard players set @s ch.blood.dealt 0
scoreboard players add @s ch.blood.vit 0
scoreboard players set @s ch.blood.tol 0
scoreboard players operation @s ch.meter = @s ch.blood.vit
playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1 0.6
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.5 ~ 0.4 0.3 0.4 0 20
