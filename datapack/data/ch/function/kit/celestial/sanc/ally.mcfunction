# An ally inside the sanctuary.
effect give @s minecraft:regeneration 2 1 true
execute if entity @a[tag=ch.caster,scores={ch.b2=2..},limit=1] run effect give @s minecraft:resistance 2 0 true
execute if entity @a[tag=ch.caster,scores={ch.b2=5..},limit=1] run function ch:kit/celestial/sanc/cleanse
particle minecraft:heart ~ ~1.9 ~ 0.2 0.1 0.2 0 1
particle minecraft:end_rod ~ ~0.5 ~ 0.2 0.4 0.2 0.02 2
