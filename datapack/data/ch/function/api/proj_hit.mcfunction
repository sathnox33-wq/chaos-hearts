$execute positioned ~-0.5 ~-0.5 ~-0.5 run tag @e[dx=0,dy=0,dz=0,type=!#ch:ignore,tag=!$(ignore),tag=!ch.noability,tag=!ch.ph$(id)] add ch.target
$execute if score #pvp ch.g matches 0 run tag @a[tag=ch.target,tag=!ch.powner] remove ch.target
$tag @e[tag=ch.target] add ch.ph$(id)
$function $(hit)
tag @e remove ch.target
$execute if score #pvp ch.g matches 1 if entity @s[tag=!ch.pdead] if data storage ch:tmp p{pierce:1} if score #steps ch.tmp matches 1.. at @s run return run function ch:api/proj_step with storage ch:tmp p
execute if data storage ch:tmp p{pierce:1} run return 0
function ch:api/proj_end with storage ch:tmp p
