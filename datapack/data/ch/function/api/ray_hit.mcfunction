execute positioned ~-0.5 ~-0.5 ~-0.5 run tag @e[dx=0,dy=0,dz=0,type=!#ch:ignore,tag=!ch.rself,tag=!ch.noability,sort=nearest,limit=1] add ch.target
scoreboard players set #rayhit ch.tmp 1
function ch:api/ray_end
