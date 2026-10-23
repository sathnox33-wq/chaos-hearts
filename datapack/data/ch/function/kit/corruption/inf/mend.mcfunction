# Self-infestation: the carrier is mended for every victim.
execute if score #hits ch.tmp matches 1.. run function ch:api/heal {n:2}
execute if score #hits ch.tmp matches 3.. run function ch:api/heal {n:4}
