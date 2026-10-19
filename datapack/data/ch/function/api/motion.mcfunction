# Sets the Motion of @s (not a player) from #vx #vy #vz ch.tmp.
execute store result entity @s Motion[0] double 0.001 run scoreboard players get #vx ch.tmp
execute store result entity @s Motion[1] double 0.001 run scoreboard players get #vy ch.tmp
execute store result entity @s Motion[2] double 0.001 run scoreboard players get #vz ch.tmp
