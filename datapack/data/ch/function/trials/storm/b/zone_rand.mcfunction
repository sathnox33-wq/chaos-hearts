# A static zone at a random floor point.
execute store result storage ch:tstorm r.a int 1 run random value 0..359
execute store result storage ch:tstorm r.d int 1 run random value 4..22
function ch:trials/storm/b/point with storage ch:tstorm r
execute at @e[type=marker,tag=ch.storm.pt,distance=..80,limit=1] run function ch:trials/storm/b/zone
kill @e[type=marker,tag=ch.storm.pt,distance=..80]
