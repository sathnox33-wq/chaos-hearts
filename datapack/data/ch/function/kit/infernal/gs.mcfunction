# As an entity: moves it up out of solid blocks or down onto the ground, #i_sn steps at most.
execute unless block ~ ~ ~ #ch:passable if score #i_sn ch.tmp matches 1.. run return run function ch:kit/infernal/gs_up
execute if block ~ ~-1 ~ #ch:passable if score #i_sn ch.tmp matches 1.. run return run function ch:kit/infernal/gs_down
