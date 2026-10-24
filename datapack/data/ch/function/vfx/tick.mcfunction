# As a timeline marker: follow the owner if asked, move and turn, draw this frame, then count down.
execute if entity @s[tag=ch.vfol] unless function ch:vfx/follow run return run kill @s
execute at @s run function ch:vfx/run with entity @s data
scoreboard players add @s ch.t 1
execute if score @s ch.t >= @s ch.life run kill @s
