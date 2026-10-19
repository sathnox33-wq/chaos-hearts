execute in minecraft:overworld run tp @s @e[type=marker,tag=ch.altar,limit=1,sort=nearest]
execute unless entity @s[gamemode=creative] run gamemode survival @s
