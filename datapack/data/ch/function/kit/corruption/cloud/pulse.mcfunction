# The cloud's particles and its poison.
$particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.8} ~ ~0.4 ~ $(h) 0.35 $(h) 0 14
$particle minecraft:dust{color:[0.239,0.102,0.322],scale:1.5} ~ ~1 ~ $(h) 0.4 $(h) 0 8
$particle minecraft:sneeze ~ ~0.6 ~ $(h) 0.3 $(h) 0.01 4
$particle minecraft:spore_blossom_air ~ ~1 ~ $(h) 0.5 $(h) 0 3
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r),limit=16] run function ch:kit/corruption/cloud/touch
