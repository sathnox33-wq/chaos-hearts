# A streak to a random point of the track.
execute store result storage ch:tspeed r.a int 1 run random value 0..359
execute store result storage ch:tspeed r.d int 1 run random value 5..20
function ch:trials/speed/b/point with storage ch:tspeed r
function ch:trials/speed/b/seg
