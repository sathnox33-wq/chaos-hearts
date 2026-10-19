execute store result score #now ch.g run time query gametime
scoreboard players operation #t20 ch.g = #now ch.g
scoreboard players operation #t20 ch.g %= #20 ch.g
execute if score #t20 ch.g matches 0 store result score #pvp ch.g run gamerule pvp
execute as @a[tag=!ch.init] at @s run function ch:core/player/first_join
execute as @a[scores={ch.leave=1..}] at @s run function ch:core/player/rejoin
execute as @a at @s run function ch:core/player/tick
function ch:gen/kit_tick
execute if entity @e[type=item_display,tag=ch.token,limit=1] run function ch:heart/token/tick_all
execute if score #t20 ch.g matches 0 run function ch:heart/sweep
execute if entity @e[type=marker,tag=ch.later,limit=1] as @e[type=marker,tag=ch.later] at @s run function ch:api/later_tick
execute if entity @e[type=item_display,tag=ch.proj,limit=1] as @e[type=item_display,tag=ch.proj] at @s run function ch:api/proj_tick
execute if score #stuns ch.g matches 1 run scoreboard players set #stuns ch.g 0
execute as @e[scores={ch.stun=1..}] at @s run function ch:api/stun_tick
execute if score #fx ch.g matches 1 run function ch:core/fx_tick
function ch:altar/tick
function ch:trial/tick
execute if entity @a[scores={ch.eye=1..},limit=1] run function ch:eye/tick
tag @a remove ch.caster
tag @e remove ch.target
tag @e[tag=ch.lnew] remove ch.lnew
kill @e[type=marker,tag=ch.rayend]
