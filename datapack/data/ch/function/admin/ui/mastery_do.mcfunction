# Panel: code 10000 + i*1000 + level sets the picked player's mastery of heart i.
scoreboard players operation #al ch.tmp = #c ch.tmp
scoreboard players set #k ch.tmp 1000
scoreboard players operation #al ch.tmp %= #k ch.tmp
scoreboard players operation #ai ch.tmp = #c ch.tmp
scoreboard players remove #ai ch.tmp 10000
scoreboard players operation #ai ch.tmp /= #k ch.tmp
execute store result storage ch:tmp am.level int 1 run scoreboard players get #al ch.tmp
function ch:gen/admin_heart {f:"ch:admin/ui/mastery_set"}
