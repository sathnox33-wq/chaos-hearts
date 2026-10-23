# Picks a random spot within 6 blocks of the challenger for a star.
execute store result storage ch:tmp tr.x int 1 run random value -6..6
execute store result storage ch:tmp tr.z int 1 run random value -6..6
execute at @a[tag=ch.challenger,limit=1] run function ch:trials/celestial/sf_at with storage ch:tmp tr
