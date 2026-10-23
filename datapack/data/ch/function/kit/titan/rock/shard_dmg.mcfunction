# Shard damage on one target.
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.3,y:0.2}
particle minecraft:block{block_state:"minecraft:cobblestone"} ~ ~1 ~ 0.2 0.3 0.2 0.1 10
scoreboard players add @a[tag=ch.caster,limit=1] ch.titan.trem 2
