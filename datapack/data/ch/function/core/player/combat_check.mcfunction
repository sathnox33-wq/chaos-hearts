# The fight ends when the opponent is no longer online (they fled, so the one who stayed loses nothing).
scoreboard players operation #opp ch.tmp = @s ch.opp
scoreboard players set #found ch.tmp 0
execute as @a if score @s ch.pid = #opp ch.tmp run scoreboard players set #found ch.tmp 1
execute if score #found ch.tmp matches 0 run scoreboard players set @s ch.ctag 0
