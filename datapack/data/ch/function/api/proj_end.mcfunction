# Ends a projectile: runs its end function and removes it.
execute if entity @s[tag=ch.pdead] run return 0
tag @s add ch.pdead
$execute at @s run function $(end)
$tag @e[tag=ch.ph$(id)] remove ch.ph$(id)
kill @s
