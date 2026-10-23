# Time Theft: three clock fields (one under the challenger) where time runs slow.
scoreboard players set @s ch.v5 0
tellraw @a[tag=ch.challenger] {text:"Time slows in the clock fields!",color:"#29D3F2",italic:true}
execute as @a[tag=ch.challenger,limit=1] at @s positioned ~ 100 ~ run function ch:trials/speed/b/zone
execute store result storage ch:tspeed r.a int 1 run random value 0..359
execute store result storage ch:tspeed r.d int 1 run random value 5..20
function ch:trials/speed/b/point with storage ch:tspeed r
execute at @e[type=marker,tag=ch.speed.pt,distance=..80,limit=1] run function ch:trials/speed/b/zone
execute store result storage ch:tspeed r.a int 1 run random value 0..359
execute store result storage ch:tspeed r.d int 1 run random value 5..20
function ch:trials/speed/b/point with storage ch:tspeed r
execute at @e[type=marker,tag=ch.speed.pt,distance=..80,limit=1] run function ch:trials/speed/b/zone
kill @e[type=marker,tag=ch.speed.pt,distance=..80]
