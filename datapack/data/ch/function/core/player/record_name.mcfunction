# Stores this player's name under their id so menus can show names of offline players.
execute unless entity @e[type=item_display,tag=ch.helper,limit=1] run return fail
loot replace entity @e[type=item_display,tag=ch.helper,limit=1] contents loot ch:player_head
data modify storage ch:tmp n set value {pid:0,name:"?"}
execute store result storage ch:tmp n.pid int 1 run scoreboard players get @s ch.pid
data modify storage ch:tmp n.name set from entity @e[type=item_display,tag=ch.helper,limit=1] item.components."minecraft:profile".name
function ch:core/player/record_name2 with storage ch:tmp n
item replace entity @e[type=item_display,tag=ch.helper,limit=1] contents with minecraft:air
