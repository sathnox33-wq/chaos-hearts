# As an enemy lashed by Ball Lightning.
tag @s add ch.storm.nx
execute positioned as @e[type=item_display,tag=ch.proj,distance=..5,limit=1,sort=nearest] run function ch:kit/storm/fn/arc
function ch:kit/storm/fn/zap
tag @s remove ch.storm.nx
