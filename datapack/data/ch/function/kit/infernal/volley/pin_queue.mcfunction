# Queues pinwheel shots #i_k .. #i_n-1, one tick apart.
execute if score #i_k ch.tmp >= #i_n ch.tmp run return 0
function ch:api/later {t:1,then:"ch:kit/infernal/volley/pin_later"}

scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.t += #i_k ch.tmp
scoreboard players remove @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.t 1
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 = #i_k ch.tmp
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v2 = #i_n ch.tmp
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v3 = #i_yaw ch.tmp
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v4 = #i_st ch.tmp
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
scoreboard players add #i_k ch.tmp 1
function ch:kit/infernal/volley/pin_queue
