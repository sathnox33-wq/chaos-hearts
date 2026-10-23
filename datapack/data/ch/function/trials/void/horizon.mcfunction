# Phase 3, every tick from ambient (at the centre): the singularity spins, pulls the challenger, and burns at its core.
execute positioned ~ ~3 ~ as @e[type=item_display,tag=ch.void.hzd,distance=..1] run rotate @s ~5 ~
particle minecraft:portal ~ ~3 ~ 0 0 0 6 16 force
particle minecraft:dust{color:[0.039,0.0,0.078],scale:2.5} ~ ~1.5 ~ 4 0.5 4 0 4
scoreboard players operation #vb ch.tmp = #now ch.g
scoreboard players operation #vb ch.tmp %= #20 ch.g
execute if score #vb ch.tmp matches 0 as @a[tag=ch.challenger,distance=4..30,limit=1] run function ch:api/pull {s:0.4}
execute if score #vb ch.tmp matches 10 as @a[tag=ch.challenger,distance=..4] run function ch:trials/void/strike {d:30}
execute if score #vb ch.tmp matches 0 run playsound minecraft:block.portal.ambient hostile @a ~ ~ ~ 1.5 0.5
