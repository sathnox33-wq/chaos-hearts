# Once a second: dropped hearts whose floating token sits in an unloaded chunk still return on time.
execute unless data storage ch:reg hearts[{state:"dropped"}] run return 0
data modify storage ch:tmp slist set value []
data modify storage ch:tmp slist append from storage ch:reg hearts[{state:"dropped"}]
function ch:heart/sweep_loop
