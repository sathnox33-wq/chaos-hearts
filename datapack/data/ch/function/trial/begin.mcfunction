# Claims slot #free, remembers where the player stood and pulls them in through the altar.
execute store result storage ch:tmp tb.s int 1 run scoreboard players get #free ch.tmp
execute store result storage ch:tmp tb.x int 1024 run scoreboard players get #free ch.tmp
execute store result storage ch:tmp tb.pid int 1 run scoreboard players get @s ch.pid
execute store result storage ch:tmp tb.hid int 1 run scoreboard players get @s ch.active
function ch:trial/begin2 with storage ch:tmp tb
