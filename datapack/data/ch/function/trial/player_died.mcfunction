# A challenger died outright (the ward was not in hand).
scoreboard players operation #slot ch.tmp = @s ch.trial
scoreboard players remove #slot ch.tmp 1
execute store result storage ch:tmp n.s int 1 run scoreboard players get #slot ch.tmp
function ch:trial/ward_used2 with storage ch:tmp n
