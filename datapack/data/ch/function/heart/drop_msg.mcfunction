# Tells the victim and the collector what happened.
data modify storage ch:tmp args.cname set value "Their killer"
$data modify storage ch:tmp args.cname set from storage ch:data names[{pid:$(col)}].name
function ch:heart/drop_msg2 with storage ch:tmp args
