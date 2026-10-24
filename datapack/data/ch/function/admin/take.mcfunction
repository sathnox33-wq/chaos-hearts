# Op: /function ch:admin/take {player:"Name",heart:"rage"} removes one heart of that type. Their mastery stays.
$data modify storage ch:tmp ad set value {player:"$(player)",heart:"$(heart)"}
execute unless function ch:admin/check run return fail
function ch:admin/take_go with storage ch:tmp ad
