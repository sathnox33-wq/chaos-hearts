# Later: the echoed cut lands on the ambushed enemy.
scoreboard players operation #vo ch.tmp = @s ch.owner
execute as @e[tag=ch.void.ambt,distance=..24] if score @s ch.void.ambo = #vo ch.tmp at @s run function ch:kit/void/ambush_strike
