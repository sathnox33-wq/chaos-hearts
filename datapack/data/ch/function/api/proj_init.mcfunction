# Finishes a projectile tagged ch.pnew: owner, lifetime, speed and its own id for piercing.
$scoreboard players set @e[type=item_display,tag=ch.pnew,limit=1] ch.life $(life)
$scoreboard players set @e[type=item_display,tag=ch.pnew,limit=1] ch.v1 $(speed)
execute if entity @s[type=player] run scoreboard players operation @e[type=item_display,tag=ch.pnew,limit=1] ch.owner = @s ch.pid
execute unless entity @s[type=player] run scoreboard players operation @e[type=item_display,tag=ch.pnew,limit=1] ch.owner = @s ch.owner
scoreboard players add #eid ch.g 1
execute store result entity @e[type=item_display,tag=ch.pnew,limit=1] item.components."minecraft:custom_data".id int 1 run scoreboard players operation @e[type=item_display,tag=ch.pnew,limit=1] ch.eid = #eid ch.g
tag @e[type=item_display,tag=ch.pnew] add ch.lnew
tag @e[type=item_display,tag=ch.pnew] remove ch.pnew
