# The field's particles and its victims.
$particle minecraft:dust{color:[0.239,0.102,0.322],scale:1.5} ~ ~0.1 ~ $(h) 0 $(h) 0 16
$particle minecraft:dust{color:[0.784,0.831,0.165],scale:1.1} ~ ~0.1 ~ $(h) 0 $(h) 0 8
$particle minecraft:sculk_charge_pop ~ ~0.15 ~ $(h) 0 $(h) 0.01 4
$particle minecraft:mycelium ~ ~0.3 ~ $(h) 0.1 $(h) 0 10
$execute if score #ct ch.tmp matches 0 run particle minecraft:sculk_soul ~ ~0.3 ~ $(h) 0.1 $(h) 0.02 3
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r),limit=16] run function ch:kit/corruption/rot/touch
