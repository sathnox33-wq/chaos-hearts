# Moment Shell: the field rides with its owner (it ends if they are gone).
scoreboard players operation #o ch.speed.g = @s ch.owner
tag @a remove ch.speed.fo
execute as @a[distance=..12] if score @s ch.pid = #o ch.speed.g run tag @s add ch.speed.fo
execute unless entity @a[tag=ch.speed.fo,limit=1] run scoreboard players set @s ch.life 0
execute at @a[tag=ch.speed.fo,limit=1] run tp @s ~ ~0.1 ~
tag @a remove ch.speed.fo
