# Every half second: new arrivals are caught, everyone inside is held and owes time (Chrono Collapse).
function ch:api/tag_owner
tag @s add ch.speed.fcur
scoreboard players operation #s ch.speed.g = @s ch.life
scoreboard players add #s ch.speed.g 19
scoreboard players operation #s ch.speed.g /= #20 ch.g
data modify storage ch:kspeed fcc set value {effect:"minecraft:slowness",sec:1,amp:3}
execute store result storage ch:kspeed fcc.sec int 1 run scoreboard players get #s ch.speed.g
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.speed.fz,distance=..$(r)] at @s run function ch:kit/speed/frac/catch
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] at @s run function ch:kit/speed/frac/hold
execute if score @s ch.v4 matches 3.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"speed",n:2}
scoreboard players operation #k ch.speed.g = @s ch.life
scoreboard players operation #k ch.speed.g %= #20 ch.g
execute if score #k ch.speed.g matches 0..9 run playsound minecraft:block.note_block.hat player @a ~ ~ ~ 1 1.4
execute if score #k ch.speed.g matches 10.. run playsound minecraft:block.note_block.hat player @a ~ ~ ~ 1 1.0
tag @s remove ch.speed.fcur
tag @a remove ch.caster
