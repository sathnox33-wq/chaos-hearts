# Down: windup (heartbeat, closing ring), then two yanks and the collapse.
execute if score @s ch.t matches 1 run playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 2 0.5
execute if score @s ch.t matches 11 run playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 2 0.7
execute if score @s ch.t matches 21 run playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 2 0.9
execute if score @s ch.t matches 26 run playsound chaoshearts:void_singularity player @a ~ ~ ~ 2 1.8
particle minecraft:portal ~ ~ ~ 0 0 0 6 20
particle minecraft:dust{color:[0.039,0.0,0.078],scale:2.0} ~ ~-0.8 ~ 4 0.1 4 0 10
scoreboard players set #sp ch.tmp 1400
execute store result storage ch:void s.p double 0.001 run scoreboard players get #sp ch.tmp
execute store result storage ch:void s.r float 0.1 run scoreboard players get @s ch.v2
scoreboard players set #vt10 ch.tmp 0
execute if score @s ch.life matches 6 run function ch:kit/void/sing/pull with storage ch:void s
execute if score @s ch.life matches 6 run function ch:api/fx/shake {s:2,t:6,r:16}
scoreboard players set #vt10 ch.tmp 1
execute if score @s ch.life matches 3 run function ch:kit/void/sing/pull with storage ch:void s
execute if score @s ch.life matches ..0 run function ch:kit/void/sing/collapse
