# Real lightning drinks from one of the rim rods (never near the challenger).
execute store result storage ch:tstorm rb.a int 22.5 run random value 0..15
function ch:trials/storm/rod_bolt2 with storage ch:tstorm rb
