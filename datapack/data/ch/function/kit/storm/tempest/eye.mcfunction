# Eye of the Storm, every tick: the wall of wind turns, enemies are dragged inward, bolts fall every 12 ticks.
scoreboard players remove @s ch.life 1
execute at @s run tp @s ~ ~ ~ ~11 0
execute store result storage ch:kstorm e.r int 1 run scoreboard players get @s ch.v1
execute if score #t2 ch.storm.g matches 0 run function ch:kit/storm/tempest/eye_fx with storage ch:kstorm e
execute if score #t10 ch.storm.g matches 0 run function ch:kit/storm/tempest/eye_pull with storage ch:kstorm e
scoreboard players operation #k ch.storm.g = @s ch.life
scoreboard players operation #k ch.storm.g %= #c12 ch.storm.g
execute if score #k ch.storm.g matches 0 run function ch:kit/storm/tempest/eye_bolts with storage ch:kstorm e
execute if score @s ch.life matches ..0 run function ch:kit/storm/tempest/eye_end
