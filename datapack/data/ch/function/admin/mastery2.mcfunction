$scoreboard players operation @s ch.xp.$(h) = #tot ch.tmp
$scoreboard players set @s ch.lvl.$(h) 0
$function ch:gen/level/$(h)
function ch:gen/sync_active
