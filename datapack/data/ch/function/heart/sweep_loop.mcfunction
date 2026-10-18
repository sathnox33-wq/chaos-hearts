execute unless data storage ch:tmp slist[0] run return 0
execute store result score #e ch.tmp run data get storage ch:tmp slist[0].exp
data modify storage ch:tmp t set value {}
data modify storage ch:tmp t.id set from storage ch:tmp slist[0].id
execute if score #e ch.tmp <= #now ch.g run function ch:heart/return with storage ch:tmp t
data remove storage ch:tmp slist[0]
function ch:heart/sweep_loop
