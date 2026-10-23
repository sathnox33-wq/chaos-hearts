# Sigil timing: grows next tick, fades at the end of its life.
$scoreboard players set @s ch.life $(life)
scoreboard players operation @s ch.t = #now ch.g
execute rotated 0 0 run tp @s ~ ~ ~ 0 0
scoreboard players set #fx ch.g 1
