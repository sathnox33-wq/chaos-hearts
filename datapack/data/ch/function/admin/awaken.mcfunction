# Op: /function ch:admin/awaken {player:"Name",heart:"rage"} awakens a heart as if its trial was won.
$data modify storage ch:tmp ad set value {player:"$(player)",heart:"$(heart)"}
execute unless function ch:admin/check run return fail
function ch:admin/awaken_go with storage ch:tmp ad
