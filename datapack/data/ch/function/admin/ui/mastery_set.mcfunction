# Internal: sets the picked player's mastery of heart $(heart) to storage ch:tmp am.level.
$data modify storage ch:tmp am.heart set value "$(heart)"
data modify storage ch:tmp am.player set value "@a[tag=ch.adtgt,limit=1]"
function ch:admin/mastery with storage ch:tmp am
