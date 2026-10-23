# While a Colossus: footsteps (Quake Step), the Bastion's quake pulses, falling grit, the timer.
scoreboard players remove @s ch.titan.col 1
execute if score @s ch.titan.colm matches 2 run function ch:kit/titan/col/bastion_tick
execute unless score @s ch.titan.colm matches 2 run function ch:kit/titan/col/walk_tick
execute if score #ti_t4 ch.tmp matches 0 run particle minecraft:dust{color:[0.788,0.643,0.361],scale:1.4} ~ ~2 ~ 0.8 1.4 0.8 0 4
execute if score #ti_t4 ch.tmp matches 2 run particle minecraft:falling_dust{block_state:"minecraft:gravel"} ~ ~2.5 ~ 0.7 0.8 0.7 0 3
execute if score @s ch.titan.col matches 60 run function ch:core/msg/say {m:"Colossus fading...",c:"#C9A45C"}
execute if score @s ch.titan.col matches 0 run function ch:kit/titan/col/end
