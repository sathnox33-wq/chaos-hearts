# As an entity: moves it up out of solid blocks or down onto the ground, #f_sn steps at most.
execute unless block ~ ~ ~ #ch:passable if score #f_sn ch.tmp matches 1.. run return run function ch:kit/frozen/gs_up
execute if block ~ ~-1 ~ #ch:passable if score #f_sn ch.tmp matches 1.. run return run function ch:kit/frozen/gs_down
