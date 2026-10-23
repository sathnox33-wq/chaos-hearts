# Level: the hole opens 1.5 blocks above where the look lands (up to 24 blocks).
function ch:api/ray {range:24}
tag @e[tag=ch.target] remove ch.target
execute at @e[type=marker,tag=ch.rayend,limit=1] positioned ~ ~1.5 ~ run function ch:kit/void/sing/spawn
