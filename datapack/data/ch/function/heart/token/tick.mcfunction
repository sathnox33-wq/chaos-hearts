# A dropped heart: spins, glows and waits for its victor.
tp @s ~ ~ ~ ~8 ~
scoreboard players operation #c ch.tmp = @s ch.owner
tag @s add ch.this
execute as @a[distance=..1.8,gamemode=!spectator] if score @s ch.pid = #c ch.tmp run function ch:heart/token/collect
execute if entity @s[tag=ch.this] as @a[distance=..1.8,gamemode=!spectator] unless score @s ch.pid = #c ch.tmp run title @s actionbar {text:"This heart can only be claimed by its victor.",color:"red"}
tag @s remove ch.this
execute if score #t20 ch.g matches 0 run function ch:heart/token/slow
particle minecraft:dust{color:[0.75,0.2,1.0],scale:0.8} ~ ~0.1 ~ 0.25 0.25 0.25 0 2
execute if score #t20 ch.g matches 0 run particle minecraft:end_rod ~ ~ ~ 0.3 0.3 0.3 0.02 3
