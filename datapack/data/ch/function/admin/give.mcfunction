# Op: /function ch:admin/give {player:"Name",heart:"rage"} creates a new heart for a player (@s for yourself; any
# selector works). Ignores the unique and max-hearts limits.
$data modify storage ch:tmp ad set value {player:"$(player)",heart:"$(heart)"}
execute unless function ch:admin/check run return fail
function ch:admin/give_go with storage ch:tmp ad
