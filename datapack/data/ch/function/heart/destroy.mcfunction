# Removes one heart of type $(h) from this player and deletes it from the registry. Mastery is kept.
execute store result storage ch:tmp args.pid int 1 run scoreboard players get @s ch.pid
$data modify storage ch:tmp args.h set value "$(h)"
$execute store result storage ch:tmp args.i int 1 run function ch:gen/index/$(h)
function ch:heart/find_held with storage ch:tmp args
$execute if score #id ch.tmp matches 0 unless score @s ch.cnt.$(h) matches 1.. run return fail
execute store result storage ch:tmp args.id int 1 run scoreboard players get #id ch.tmp
function ch:heart/destroy2 with storage ch:tmp args
return 1
