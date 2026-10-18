scoreboard players add #hid ch.g 1
scoreboard players operation #id ch.tmp = #hid ch.g
$data modify storage ch:reg hearts append value {id:0,type:"$(h)",state:"held",holder:$(pid)}
execute store result storage ch:reg hearts[-1].id int 1 run scoreboard players get #id ch.tmp
