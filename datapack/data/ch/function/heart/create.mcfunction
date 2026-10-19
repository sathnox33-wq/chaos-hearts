# Creates a brand new heart of type $(h) (index $(i)) for this player. $(force) 1 skips the unique and max-hearts limits.
# Returns 1 on success.
$scoreboard players set #force ch.tmp $(force)
$execute if score #force ch.tmp matches 0 if score #unique ch.cfg matches 1 if data storage ch:reg hearts[{type:"$(h)"}] run return fail
execute if score #force ch.tmp matches 0 unless function ch:heart/has_room run return fail
scoreboard players add #hid ch.g 1
$data modify storage ch:reg hearts append value {id:0,type:"$(h)",state:"held",holder:0}
execute store result storage ch:reg hearts[-1].id int 1 run scoreboard players get #hid ch.g
execute store result storage ch:reg hearts[-1].holder int 1 run scoreboard players get @s ch.pid
$data modify storage ch:tmp args set value {h:"$(h)",i:$(i)}
execute store result storage ch:tmp args.id int 1 run scoreboard players get #hid ch.g
function ch:heart/gain with storage ch:tmp args
return 1
