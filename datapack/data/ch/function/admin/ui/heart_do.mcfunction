# Runs $(f) {heart:"<name>"} for heart index #c - $(o).
scoreboard players operation #ai ch.tmp = #c ch.tmp
$scoreboard players remove #ai ch.tmp $(o)
$function ch:gen/admin_heart {f:"$(f)"}
