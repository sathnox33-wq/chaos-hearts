# The Focus landed in the off hand (swap-hands key). Put both hands back and cast Ability 3, or the Ultimate while sneaking.
item replace entity @e[type=item_display,tag=ch.helper,limit=1] contents from entity @s weapon.mainhand
item replace entity @s weapon.mainhand from entity @s weapon.offhand
item replace entity @s weapon.offhand from entity @e[type=item_display,tag=ch.helper,limit=1] contents
item replace entity @e[type=item_display,tag=ch.helper,limit=1] contents with minecraft:air
execute if predicate ch:sneaking run return run function ch:core/cast {slot:4}
function ch:core/cast {slot:3}
