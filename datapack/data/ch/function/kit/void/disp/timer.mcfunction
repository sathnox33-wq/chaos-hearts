# Switcheroo window counts down; when it ends, untag the displaced target.
scoreboard players remove @s ch.void.swt 1
execute if score @s ch.void.swt matches 1.. run return 0
scoreboard players operation #vme ch.tmp = @s ch.pid
execute as @e[tag=ch.void.sw,distance=..128] if score @s ch.void.swo = #vme ch.tmp run tag @s remove ch.void.sw
