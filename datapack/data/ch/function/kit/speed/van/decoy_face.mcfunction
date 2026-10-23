# Copies the caster's skin and name onto the new decoy through the helper display.
loot replace entity @e[type=item_display,tag=ch.helper,limit=1] contents loot ch:player_head
data modify entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] profile set from entity @e[type=item_display,tag=ch.helper,limit=1] item.components."minecraft:profile"
data modify entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] CustomName set from entity @e[type=item_display,tag=ch.helper,limit=1] item.components."minecraft:profile".name
item replace entity @e[type=item_display,tag=ch.helper,limit=1] contents with minecraft:air
