# A time fracture, every tick: the clock hand sweeps, the edge glimmers, and every half second it grips what is inside.
scoreboard players remove @s ch.life 1
execute if score @s ch.v2 matches 2 run function ch:kit/speed/frac/follow
execute at @s run tp @s ~ ~ ~ ~9 0
scoreboard players operation #fo ch.speed.g = @s ch.owner
execute store result storage ch:kspeed f.r int 1 run scoreboard players get @s ch.v1
execute store result storage ch:kspeed f.rr float 0.92 run scoreboard players get @s ch.v1
execute if score #t2 ch.speed.g matches 0 at @s rotated as @s run function ch:kit/speed/frac/hand
execute if score #t4 ch.speed.g matches 0 at @s positioned ~ ~0.2 ~ run function ch:kit/speed/frac/edge with storage ch:kspeed f
function ch:kit/speed/frac/projs with storage ch:kspeed f
execute if score #t10 ch.speed.g matches 0 run function ch:kit/speed/frac/pulse with storage ch:kspeed f
execute if score @s ch.v2 matches 1 if score @s ch.life matches ..20 run function ch:kit/speed/frac/warn
execute if score @s ch.life matches ..0 at @s run function ch:kit/speed/frac/end
