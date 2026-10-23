# Speed holder was hurt: a hit drags you out of Afterimage; Phase Runner lets a quarter of blows pass through.
execute if score @s ch.speed.van matches 1.. run function ch:kit/speed/van/reveal
execute if score @s ch.speed.slip matches 1.. if score @s ch.b2 matches 5.. run function ch:kit/speed/p/phase
