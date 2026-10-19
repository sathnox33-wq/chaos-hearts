# Casts ability $(slot) of the active heart if it is unlocked and ready. #var: 0 level, 1 looking up, 2 looking down.
execute if score @s ch.active matches 0 run return run function ch:core/msg/say {m:"You hold no Chaos Heart. Win one in PvP.",c:"gray"}
execute if entity @s[gamemode=spectator] run return fail
execute if score @s ch.eye matches 1.. run return fail
$scoreboard players set #slot ch.tmp $(slot)
$execute if score @s ch.lvl < #unlock$(slot) ch.g run return run function ch:core/msg/locked {slot:$(slot)}
$execute if score @s ch.cd$(slot) matches 1.. run return run playsound minecraft:block.dispenser.fail player @s ~ ~ ~ 0.4 1.8
scoreboard players set #var ch.tmp 0
execute if entity @s[x_rotation=-90..-35] run scoreboard players set #var ch.tmp 1
execute if entity @s[x_rotation=35..90] run scoreboard players set #var ch.tmp 2
scoreboard players set #mov ch.tmp 0
execute if predicate ch:input/forward run scoreboard players set #mov ch.tmp 1
scoreboard players set #hits ch.tmp 0
tag @s add ch.caster
execute store result score #ok ch.tmp run function ch:gen/cast
execute if score #ok ch.tmp matches 1.. run function ch:gen/cd_default
tag @s remove ch.caster
scoreboard players set @s ch.hud 5
execute if score #ok ch.tmp matches 0 run playsound minecraft:block.dispenser.fail player @s ~ ~ ~ 0.5 1.4
