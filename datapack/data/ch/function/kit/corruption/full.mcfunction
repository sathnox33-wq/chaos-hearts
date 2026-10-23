# Contagion reached 100: the next Plague Bolt is a Pestilence Bolt.
tag @s add ch.corruption.full
playsound minecraft:block.sculk_catalyst.bloom player @s ~ ~ ~ 1 0.6
playsound chaoshearts:corruption_spread player @s ~ ~ ~ 0.6 1.4
function ch:core/msg/say {m:"Pestilence ready: your next Plague Bolt is empowered.",c:"#A4FF4F"}
