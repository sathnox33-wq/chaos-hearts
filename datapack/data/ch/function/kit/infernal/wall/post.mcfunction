# A Flame Wall segment, every tick: flames, marching, projectile incineration, burning and Cinder Shield.
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players remove @s ch.life 1
scoreboard players add @s ch.v1 1
execute if score @s ch.life matches ..0 run return run function ch:kit/infernal/wall/post_end
execute if score @s ch.v2 matches 1.. run function ch:kit/infernal/wall/march
execute if score @s ch.v6 matches 1 run particle minecraft:soul_fire_flame ~ ~0.9 ~ 0.18 0.7 0.18 0.02 4
execute unless score @s ch.v6 matches 1 run particle minecraft:flame ~ ~0.9 ~ 0.18 0.7 0.18 0.02 4
particle minecraft:small_flame ~ ~2 ~ 0.2 0.6 0.2 0.03 1
scoreboard players operation #i_p ch.tmp = @s ch.v1
scoreboard players operation #i_p ch.tmp %= #4 ch.g
execute if score #i_p ch.tmp matches 0 run function ch:kit/infernal/wall/flicker
execute if score #i_p ch.tmp matches 2 run particle minecraft:large_smoke ~ ~3.2 ~ 0.2 0.2 0.2 0.01 1
execute positioned ~ ~1.5 ~ if entity @e[type=#minecraft:impact_projectiles,distance=..2.3,limit=1] run function ch:kit/infernal/wall/burn_all
execute positioned ~ ~1.5 ~ if entity @e[type=item_display,tag=ch.proj,distance=..2,limit=1] run function ch:kit/infernal/wall/burn_all
scoreboard players operation #i_p ch.tmp = @s ch.v1
scoreboard players operation #i_p ch.tmp %= #10 ch.g
execute if score #i_p ch.tmp matches 0 run function ch:kit/infernal/wall/burn
tag @a remove ch.caster
