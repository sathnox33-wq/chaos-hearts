# The active heart left: the most recent remaining heart becomes active.
function ch:gen/latest
execute store result storage ch:tmp n.i int 1 run scoreboard players get #bestidx ch.tmp
function ch:heart/set_active with storage ch:tmp n
