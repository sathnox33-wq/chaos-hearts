# Fails if the player is at the max-hearts limit.
execute if score #max_hearts ch.cfg matches 0 run return 1
function ch:gen/count
execute if score #owned ch.tmp >= #max_hearts ch.cfg run return fail
return 1
