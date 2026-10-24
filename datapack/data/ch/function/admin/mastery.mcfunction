# Op: /function ch:admin/mastery {player:"Name",heart:"rage",level:100} sets mastery (0..100) on a heart type.
$data modify storage ch:tmp ad set value {player:"$(player)",heart:"$(heart)",level:$(level)}
execute unless function ch:admin/check run return fail
function ch:admin/mastery_go with storage ch:tmp ad
