# Schedules the next jump from here.
function ch:api/later {t:2,then:"ch:kit/storm/chain/hop"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/storm/fn/cfg
