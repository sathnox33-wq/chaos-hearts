# Blood Moon Strength for its duration.
$scoreboard players set #s ch.tmp $(t)
scoreboard players operation #s ch.tmp /= #20 ch.g
execute store result storage ch:tmp blood.s int 1 run scoreboard players get #s ch.tmp
function ch:kit/blood/moon/buff2 with storage ch:tmp blood
