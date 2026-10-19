# Makes the next held heart (by heart order, wrapping round) the active one.
execute if score @s ch.eye matches 1.. run return fail
function ch:gen/count
execute if score #owned ch.tmp matches ..1 run return run function ch:core/input/shuffle_none
execute if score @s ch.swapcd matches 1.. run return run playsound minecraft:block.dispenser.fail player @s ~ ~ ~ 0.4 1.6
function ch:gen/next_held
execute if score #next ch.tmp = @s ch.active run return fail
scoreboard players operation @s ch.swapcd = #swap_sec ch.cfg
scoreboard players operation @s ch.swapcd *= #20 ch.g
execute store result storage ch:tmp n.i int 1 run scoreboard players get #next ch.tmp
function ch:heart/set_active with storage ch:tmp n
function ch:core/input/shuffle_fx
