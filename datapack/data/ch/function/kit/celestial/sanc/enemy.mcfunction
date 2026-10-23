# An enemy inside the sanctuary: weakened; undead are set alight.
effect give @s minecraft:weakness 2 0 true
execute if entity @s[type=#ch:undead,type=!player] run data merge entity @s {Fire:40s}
particle minecraft:dust{color:[1.0,0.949,0.69],scale:0.8} ~ ~1 ~ 0.3 0.5 0.3 0 3
