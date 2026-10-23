# As one enemy in the collapse: damage = 3 + 1.2 per half second of time debt.
scoreboard players operation #d ch.speed.g = @s ch.speed.debt
scoreboard players operation #d ch.speed.g *= #c12 ch.speed.g
scoreboard players add #d ch.speed.g 30
scoreboard players set @s ch.speed.debt 0
function ch:kit/speed/fn/hit
execute positioned as @e[type=marker,tag=ch.speed.frac,limit=1,sort=nearest] run function ch:api/pull {s:0.9}
particle minecraft:reverse_portal ~ ~1 ~ 0.4 0.6 0.4 0.3 25
