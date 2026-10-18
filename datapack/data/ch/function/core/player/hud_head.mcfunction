$data modify storage ch:tmp hud append value {text:"❤ $(title) ",color:"$(color)",bold:true}
execute store result storage ch:tmp n.v int 1 run scoreboard players get @s ch.lvl
function ch:core/player/hud_level with storage ch:tmp n
