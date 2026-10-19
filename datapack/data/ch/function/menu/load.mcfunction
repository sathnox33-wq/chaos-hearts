# Loads the active heart's menu text into ch:tmp m and its name/colour into ch:tmp h. Fails without a heart.
execute if score @s ch.active matches 0 run return fail
scoreboard players operation #i ch.tmp = @s ch.active
function ch:gen/describe
function ch:menu/load2 with storage ch:tmp h
return 1
