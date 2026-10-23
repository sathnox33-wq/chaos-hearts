# Close in on the quarry; bite when in reach.
execute unless entity @e[tag=ch.corruption.lt,distance=..1.6,limit=1] facing entity @e[tag=ch.corruption.lt,limit=1] feet rotated ~ 0 run function ch:kit/corruption/ling/move
execute if entity @e[tag=ch.corruption.lt,distance=..1.6,limit=1] run tp @s ~ ~ ~ facing entity @e[tag=ch.corruption.lt,limit=1] feet
execute if score @s ch.v1 matches ..0 if entity @e[tag=ch.corruption.lt,distance=..1.9,limit=1] run function ch:kit/corruption/ling/bite
