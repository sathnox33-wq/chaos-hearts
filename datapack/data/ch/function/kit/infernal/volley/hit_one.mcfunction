# As a fireball's target.
execute store result score #i_ok ch.tmp run function ch:kit/infernal/sear
execute if score #i_ok ch.tmp matches 0 run return 0
execute if score #i_vid ch.tmp matches 1.. run function ch:kit/infernal/volley/count
