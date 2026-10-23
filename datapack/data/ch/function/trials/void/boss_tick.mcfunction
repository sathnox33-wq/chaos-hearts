# The Hollow Sovereign every tick: decorations, leash to the arena, and its attack rotation by phase.
scoreboard players add @s ch.void.bt 1
tp @e[type=item_display,tag=ch.void.bd,distance=..48] ~ ~ ~
execute as @e[type=item_display,tag=ch.void.bd0,distance=..3] run rotate @s ~6 ~
execute as @e[type=item_display,tag=ch.void.bd1,distance=..3] run rotate @s ~-4 ~
execute as @e[type=item_display,tag=ch.void.bd3,distance=..3] run rotate @s ~9 ~
execute as @e[type=item_display,tag=ch.void.bd4,distance=..3] run rotate @s ~-7 ~
particle minecraft:portal ~ ~2.5 ~ 0.6 1.2 0.6 0.4 4
execute unless entity @e[type=marker,tag=ch.session,distance=..26,limit=1] run function ch:trials/void/leash
scoreboard players operation #vb ch.tmp = @s ch.void.bt
scoreboard players operation #vb ch.tmp %= #40 ch.void.k
execute if score #vb ch.tmp matches 0 run data modify entity @s AngryAt set from entity @a[tag=ch.challenger,limit=1] UUID
scoreboard players operation #vb ch.tmp = @s ch.void.bt
scoreboard players operation #vb ch.tmp %= #140 ch.void.k
execute if score #vb ch.tmp matches 40 run function ch:trials/void/rift
execute if score @s ch.void.bp matches ..2 if score #vb ch.tmp matches 110 run function ch:trials/void/shadow
execute if score @s ch.void.bp matches 3.. if score #vb ch.tmp matches 90 run function ch:trials/void/shadow
execute if score @s ch.void.bp matches 3.. if score #vb ch.tmp matches 130 run function ch:trials/void/shadow
scoreboard players operation #vb ch.tmp = @s ch.void.bt
scoreboard players operation #vb ch.tmp %= #100 ch.void.k
execute if score @s ch.void.bp matches 2.. if score #vb ch.tmp matches 75 run function ch:trials/void/lances
scoreboard players operation #vb ch.tmp = @s ch.void.bt
scoreboard players operation #vb ch.tmp %= #160 ch.void.k
execute if score @s ch.void.bp matches 3.. if score #vb ch.tmp matches 20 run function ch:trials/void/cracks
