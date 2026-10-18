# Gives registry heart $(id) of type $(h) to player $(pid), now or when they next join.
$execute store result storage ch:tmp args.i int 1 run function ch:gen/index/$(h)
$data modify storage ch:reg hearts[{id:$(id)}] merge value {state:"held",holder:$(pid)}
$data remove storage ch:reg hearts[{id:$(id)}].collector
$data remove storage ch:reg hearts[{id:$(id)}].exp
$data remove storage ch:reg hearts[{id:$(id)}].pos
scoreboard players set #online ch.tmp 0
$execute as @a if score @s ch.pid matches $(pid) store success score #online ch.tmp run function ch:heart/give_back_online with storage ch:tmp args
execute if score #online ch.tmp matches 0 run function ch:heart/pending/add with storage ch:tmp args
