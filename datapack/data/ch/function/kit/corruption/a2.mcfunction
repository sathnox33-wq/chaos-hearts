# Rot Ground. Level: corrupt the ground where you look - everything on it withers and slows. Up: the rot blooms around
# you and follows you, mending you while you stand in it. Down: a sinking mire at your feet - after a 1 s windup,
# grasping roots erupt, rooting and tearing everything on it, then it festers as rot.
scoreboard players operation #cvar ch.tmp = #var ch.tmp
execute if score #cvar ch.tmp matches 0 run function ch:kit/corruption/rot/aim
execute if score #cvar ch.tmp matches 1..2 run function ch:kit/corruption/rot/spawn
playsound chaoshearts:corruption_rot player @a ~ ~ ~ 1 1
playsound minecraft:block.sculk.spread player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.wither.ambient player @a ~ ~ ~ 0.3 1.6
return 1
