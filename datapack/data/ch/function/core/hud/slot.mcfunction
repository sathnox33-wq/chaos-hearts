# One 16x16 ability icon plus its state, 18 pixels wide in all.
scoreboard players operation #c ch.tmp = @s ch.active
scoreboard players remove #c ch.tmp 1
scoreboard players operation #c ch.tmp *= #4 ch.g
$scoreboard players add #c ch.tmp $(s)
scoreboard players remove #c ch.tmp 1
execute store result storage ch:tmp n.c int 1 run scoreboard players get #c ch.tmp
data modify storage ch:tmp n.col set value "#FFFFFF"
$execute if score @s ch.lvl < #unlock$(s) ch.g run data modify storage ch:tmp n.col set value "#4A4A4A"
$execute if score @s ch.lvl >= #unlock$(s) ch.g if score @s ch.cd$(s) matches 1.. run data modify storage ch:tmp n.col set value "#8A8A8A"
function ch:core/hud/icon with storage ch:tmp n
scoreboard players set #dx ch.tmp -17
function ch:core/hud/move
$execute if score @s ch.lvl < #unlock$(s) ch.g run return run function ch:core/hud/single {g:"lock"}
$execute if score @s ch.cd$(s) matches 1.. run return run function ch:core/hud/cooling {s:$(s)}
function ch:core/hud/single {g:"ready"}
