# Vesperine's brain, every tick: her crown turns, her tether drinks, her vexes turn to blood wisps, she casts in turn.
# ch.v3: tether ticks left (drains while 1..60). ch.v4: ticks to next cast. ch.v6: phase.
scoreboard players add @s ch.v1 1
scoreboard players operation #m ch.tmp = @s ch.v1
scoreboard players operation #m ch.tmp %= #5 ch.g
execute if score #m ch.tmp matches 0 run function ch:trials/blood/boss_aura
execute if score @s ch.v3 matches 1.. run function ch:trials/blood/tether_tick
execute as @e[type=marker,tag=ch.blood.zone,distance=..64] at @s run function ch:trials/blood/zone_tick
execute as @e[type=marker,tag=ch.blood.bolt,distance=..64] at @s run function ch:trials/blood/bolt_tick
execute as @e[type=marker,tag=ch.blood.step,distance=..64] at @s run function ch:trials/blood/step_tick
execute if score #t20 ch.g matches 0 as @e[type=vex,tag=!ch.tmob,distance=..48,limit=6] run function ch:trials/blood/wisp
scoreboard players remove @s ch.v4 1
execute if score @s ch.v4 matches ..0 run function ch:trials/blood/pick
