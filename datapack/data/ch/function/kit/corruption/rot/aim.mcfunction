# Level: up to 14 blocks along the look, then down to the ground.
function ch:api/ray {range:14}
tag @e[tag=ch.target] remove ch.target
scoreboard players set #cgr ch.tmp 10
data modify storage ch:corruption g.f set value "ch:kit/corruption/rot/spawn"
execute at @e[type=marker,tag=ch.rayend,limit=1] run function ch:kit/corruption/ground
