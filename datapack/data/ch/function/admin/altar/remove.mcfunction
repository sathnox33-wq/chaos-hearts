# Op: removes the nearest Awakening Altar (within 10 blocks).
execute unless entity @e[type=marker,tag=ch.altar,distance=..10,limit=1] run return run tellraw @s {text:"No altar within 10 blocks.",color:"red"}
execute as @e[type=marker,tag=ch.altar,distance=..10,limit=1,sort=nearest] at @s positioned ~-0.5 ~-2 ~-0.5 run function ch:admin/altar/remove2
tellraw @s {text:"Altar removed.",color:"gray"}
