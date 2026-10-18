# The collect window ran out: heart $(id) goes back to the player it dropped from.
$execute unless data storage ch:reg hearts[{id:$(id),state:"dropped"}] run return run function ch:heart/token/remove {id:$(id)}
$data modify storage ch:tmp r set from storage ch:reg hearts[{id:$(id)}]
data modify storage ch:tmp args set value {}
data modify storage ch:tmp args.id set from storage ch:tmp r.id
data modify storage ch:tmp args.h set from storage ch:tmp r.type
data modify storage ch:tmp args.pid set from storage ch:tmp r.prev
$function ch:heart/token/remove {id:$(id)}
function ch:heart/give_back with storage ch:tmp args
