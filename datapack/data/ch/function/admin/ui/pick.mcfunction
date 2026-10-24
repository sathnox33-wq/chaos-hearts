# The admin picked a player: remember them and open their page.
scoreboard players operation @s ch.adt = #c ch.tmp
scoreboard players remove @s ch.adt 1000
execute unless function ch:admin/ui/tag_target run return run function ch:admin/ui/main
function ch:admin/ui/target
tag @a remove ch.adtgt
