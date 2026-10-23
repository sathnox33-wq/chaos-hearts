# Thousand Cuts: a hanging slash that bites again half a second later.
scoreboard players operation #v1 ch.speed.g = #dd ch.speed.g
scoreboard players operation #v1 ch.speed.g /= #2 ch.g
function ch:api/later {t:10,then:"ch:kit/speed/dash/recut"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/speed/fn/cfg
execute rotated ~45 0 run function ch:api/fx/sprite {model:"slash",color:16771466,s0:0.4,s1:1.6,t:10,life:12,spin:40,dy:0.0}
