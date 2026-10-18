# As the dead (or fleeing) player: their most recently acquired heart drops where they are,
# claimable only by player id #credit ch.tmp for the collect window.
function ch:gen/latest
execute if score #bestidx ch.tmp matches 0 run return fail
scoreboard players operation #i ch.tmp = #bestidx ch.tmp
function ch:gen/describe
data modify storage ch:tmp args set value {}
data modify storage ch:tmp args.h set from storage ch:tmp h.name
data modify storage ch:tmp args.i set from storage ch:tmp h.i
execute store result storage ch:tmp args.pid int 1 run scoreboard players get @s ch.pid
function ch:heart/find_held with storage ch:tmp args
# Self-heal: a heart the scoreboard knows about but the registry lost gets a fresh registry entry.
execute if score #id ch.tmp matches 0 run function ch:heart/registry_heal with storage ch:tmp args
execute store result storage ch:tmp args.id int 1 run scoreboard players get #id ch.tmp
execute store result storage ch:tmp args.col int 1 run scoreboard players get #credit ch.tmp
scoreboard players operation #exp ch.tmp = #collect_sec ch.cfg
scoreboard players operation #exp ch.tmp *= #20 ch.g
scoreboard players operation #exp ch.tmp += #now ch.g
execute store result storage ch:tmp args.exp int 1 run scoreboard players get #exp ch.tmp
data modify storage ch:tmp args.dim set from entity @s Dimension
data modify storage ch:tmp args.pos set from entity @s Pos
function ch:heart/lose with storage ch:tmp args
function ch:heart/drop_registry with storage ch:tmp args
data modify storage ch:tmp args.title set from storage ch:tmp h.title
data modify storage ch:tmp args.color set from storage ch:tmp h.color
function ch:heart/token/spawn with storage ch:tmp args
function ch:heart/drop_msg with storage ch:tmp args
