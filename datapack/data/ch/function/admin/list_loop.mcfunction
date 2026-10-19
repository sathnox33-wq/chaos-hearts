execute unless data storage ch:tmp ls[0] run return 0
data modify storage ch:tmp le set value {id:0,type:"?",state:"?",holder:0,collector:0}
data modify storage ch:tmp le merge from storage ch:tmp ls[0]
data remove storage ch:tmp ls[0]
function ch:admin/list_line with storage ch:tmp le
function ch:admin/list_loop
