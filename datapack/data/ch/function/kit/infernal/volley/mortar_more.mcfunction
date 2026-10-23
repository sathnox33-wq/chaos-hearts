# Extra Fuel: shells 4 and 5.
function ch:api/later {t:12,then:"ch:kit/infernal/volley/mortar_later"}
scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 3
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v2 = #i_n ch.tmp
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:16,then:"ch:kit/infernal/volley/mortar_later"}
scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 4
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v2 = #i_n ch.tmp
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
