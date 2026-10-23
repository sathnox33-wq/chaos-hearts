# Volley, up: 3 (5) shells lobbed high in a spread; they arc down and burst in a splash of fire. With Meteor the last is a meteor.
scoreboard players set #i_n ch.tmp 3
execute if score @s ch.b1 matches 2.. run scoreboard players set #i_n ch.tmp 5
scoreboard players set #i_k ch.tmp 0
function ch:kit/infernal/volley/mortar_shot
function ch:api/later {t:4,then:"ch:kit/infernal/volley/mortar_later"}
scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 1
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v2 = #i_n ch.tmp
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
function ch:api/later {t:8,then:"ch:kit/infernal/volley/mortar_later"}
scoreboard players set @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 2
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v2 = #i_n ch.tmp
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
execute if score #i_n ch.tmp matches 5 run function ch:kit/infernal/volley/mortar_more
return 1
