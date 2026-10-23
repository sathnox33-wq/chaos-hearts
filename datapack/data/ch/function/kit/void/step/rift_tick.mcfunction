# As an open rift: it breathes portal light; when it closes unused, Void Step's cooldown begins.
scoreboard players remove @s ch.life 1
scoreboard players operation #vt ch.tmp = @s ch.life
scoreboard players operation #vt ch.tmp %= #2 ch.g
execute if score #vt ch.tmp matches 0 run particle minecraft:portal ~ ~1 ~ 0.2 0.6 0.2 0.5 6
execute if score #vt ch.tmp matches 1 run particle minecraft:dust{color:[0.541,0.235,1.0],scale:1.2} ~ ~1 ~ 0.25 0.7 0.25 0 3
execute if score @s ch.life matches ..0 run function ch:kit/void/step/rift_close
