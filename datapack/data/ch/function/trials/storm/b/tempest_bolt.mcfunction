# A Tempest bolt mark at a random floor point (one in three right under the challenger).
scoreboard players set @s ch.v6 0
execute store result score #r ch.storm.g run random value 1..3
execute if score #r ch.storm.g matches 1 as @a[tag=ch.challenger,limit=1] at @s positioned ~ 100 ~ run function ch:trials/storm/b/mark
execute if score #r ch.storm.g matches 1 run return 0
execute store result storage ch:tstorm r.a int 1 run random value 0..359
execute store result storage ch:tstorm r.d int 1 run random value 3..24
function ch:trials/storm/b/point with storage ch:tstorm r
execute at @e[type=marker,tag=ch.storm.pt,distance=..80,limit=1] run function ch:trials/storm/b/mark
kill @e[type=marker,tag=ch.storm.pt,distance=..80]
