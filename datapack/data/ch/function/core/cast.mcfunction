# Casts ability $(slot) of the active heart if it is unlocked and ready.
execute if score @s ch.active matches 0 run return run title @s actionbar {text:"You have no heart. Win one in PvP.",color:"gray"}
execute if entity @s[gamemode=spectator] run return fail
execute if score @s ch.eye matches 1.. run return fail
$scoreboard players set #slot ch.tmp $(slot)
$execute if score @s ch.lvl < #unlock$(slot) ch.g run return run function ch:core/msg/locked {slot:$(slot)}
$execute if score @s ch.cd$(slot) matches 1.. run return run function ch:core/msg/cooling {slot:$(slot)}
tag @s add ch.caster
execute store result score #ok ch.tmp run function ch:gen/cast
tag @s remove ch.caster
execute if score #ok ch.tmp matches 0 run playsound minecraft:block.dispenser.fail player @s ~ ~ ~ 0.5 1.4
