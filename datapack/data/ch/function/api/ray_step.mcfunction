scoreboard players remove #rs ch.tmp 1
execute positioned ~-0.5 ~-0.5 ~-0.5 if entity @e[dx=0,dy=0,dz=0,type=!#ch:ignore,tag=!ch.rself,tag=!ch.noability] positioned ~0.5 ~0.5 ~0.5 run return run function ch:api/ray_hit
execute unless block ~ ~ ~ #ch:passable positioned ^ ^ ^-0.5 run return run function ch:api/ray_end
execute if score #rs ch.tmp matches ..0 run return run function ch:api/ray_end
execute positioned ^ ^ ^0.5 run function ch:api/ray_step
