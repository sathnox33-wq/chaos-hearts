# A player who logged out mid-trial is sent back to where they entered.
execute unless score @s ch.trial matches 1.. run return 0
scoreboard players operation #slot ch.tmp = @s ch.trial
scoreboard players remove #slot ch.tmp 1
execute store result storage ch:tmp n.s int 1 run scoreboard players get #slot ch.tmp
function ch:trial/rejoin2 with storage ch:tmp n
