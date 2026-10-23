# As a poison puddle (driven from ambient).
scoreboard players remove @s ch.life 1
scoreboard players operation #cb ch.tmp = @s ch.life
scoreboard players operation #cb ch.tmp %= #5 ch.g
execute if score #cb ch.tmp matches 0 run particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.3} ~ ~0.2 ~ 1.2 0.05 1.2 0 6
execute if score #cb ch.tmp matches 0 run particle minecraft:sneeze ~ ~0.3 ~ 1 0.1 1 0.01 1
execute if score #cb ch.tmp matches 0 run effect give @a[tag=ch.challenger,distance=..2.5] minecraft:poison 3 0
execute if score @s ch.life matches ..0 run kill @s
