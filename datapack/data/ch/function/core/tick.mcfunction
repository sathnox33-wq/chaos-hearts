execute store result score #now ch.g run time query gametime
scoreboard players operation #t20 ch.g = #now ch.g
scoreboard players operation #t20 ch.g %= #20 ch.g
execute as @a[tag=!ch.init] at @s run function ch:core/player/first_join
execute as @a[scores={ch.leave=1..}] at @s run function ch:core/player/rejoin
execute as @a at @s run function ch:core/player/tick
function ch:gen/kit_tick
execute if entity @e[type=item_display,tag=ch.token,limit=1] run function ch:heart/token/tick_all
execute if score #t20 ch.g matches 0 run function ch:heart/sweep
execute if entity @e[type=marker,tag=ch.later,limit=1] as @e[type=marker,tag=ch.later] at @s run function ch:api/later_tick
execute if entity @e[type=item_display,tag=ch.proj,limit=1] as @e[type=item_display,tag=ch.proj] at @s run function ch:api/proj_tick
function ch:trial/tick
execute if entity @a[scores={ch.eye=1..},limit=1] run function ch:eye/tick
tag @a remove ch.caster
tag @e remove ch.target
