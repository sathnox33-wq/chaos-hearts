# The victor touched their heart.
execute unless function ch:heart/has_room run return run title @s actionbar {text:"You cannot hold any more hearts.",color:"red"}
scoreboard players operation #id ch.tmp = @e[type=item_display,tag=ch.this,limit=1] ch.hid
scoreboard players operation #i ch.tmp = @e[type=item_display,tag=ch.this,limit=1] ch.slot
function ch:gen/describe
data modify storage ch:tmp args set value {}
data modify storage ch:tmp args.h set from storage ch:tmp h.name
data modify storage ch:tmp args.i set from storage ch:tmp h.i
execute store result storage ch:tmp args.id int 1 run scoreboard players get #id ch.tmp
execute store result storage ch:tmp args.pid int 1 run scoreboard players get @s ch.pid
function ch:heart/claim with storage ch:tmp args
tag @e[type=item_display,tag=ch.this] remove ch.this
function ch:heart/token/remove with storage ch:tmp args
particle minecraft:totem_of_undying ~ ~1 ~ 0.4 0.6 0.4 0.4 60
playsound minecraft:item.totem.use player @a ~ ~ ~ 0.6 1.5
