# Puts back the game mode and armour the player had before.
$data modify storage ch:tmp es set from storage ch:data eyestash[{pid:$(pid)}]
$data remove storage ch:data eyestash[{pid:$(pid)}]
function ch:eye/restore_slot {s:"head",to:"armor.head"}
function ch:eye/restore_slot {s:"chest",to:"armor.chest"}
function ch:eye/restore_slot {s:"legs",to:"armor.legs"}
function ch:eye/restore_slot {s:"feet",to:"armor.feet"}
execute if data storage ch:tmp es{gm:"survival"} run gamemode survival @s
execute if data storage ch:tmp es{gm:"adventure"} run gamemode adventure @s
execute unless data storage ch:tmp es.gm run gamemode survival @s
