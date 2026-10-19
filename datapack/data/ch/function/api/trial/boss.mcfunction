# As the boss a trial just spawned: adopts it, names it and links it to the slot's bossbar.
function ch:api/trial/adopt
tag @s add ch.boss
$data modify entity @s CustomName set value {text:"$(name)",color:"$(color)",bold:true}
data merge entity @s {CustomNameVisible:1b}
$data modify storage ch:tmp bossname set value "$(name)"
execute store result storage ch:tmp bb.max int 1 run attribute @s minecraft:max_health get
execute store result storage ch:tmp bb.s int 1 run scoreboard players get #slot ch.tmp
$data modify storage ch:tmp bb.color set value "$(color)"
$data modify storage ch:tmp bb.name set value "$(name)"
function ch:api/trial/boss_bar with storage ch:tmp bb
