# #avail ch.tmp = points earned on heart $(name) minus the points its tree uses.
$scoreboard players operation #avail ch.tmp = @s ch.pts.$(name)
scoreboard players operation #n ch.tmp = @s ch.b1
function ch:menu/spent
scoreboard players operation #n ch.tmp = @s ch.b2
function ch:menu/spent
scoreboard players operation #n ch.tmp = @s ch.b3
function ch:menu/spent
