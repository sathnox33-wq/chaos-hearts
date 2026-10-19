$execute unless data storage ch:tmp es.eq.$(s) run return 0
$data modify entity @e[type=item_display,tag=ch.helper,limit=1] item set from storage ch:tmp es.eq.$(s)
$item replace entity @s $(to) from entity @e[type=item_display,tag=ch.helper,limit=1] contents
item replace entity @e[type=item_display,tag=ch.helper,limit=1] contents with minecraft:air
