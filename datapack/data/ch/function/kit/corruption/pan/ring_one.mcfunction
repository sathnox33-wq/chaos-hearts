# One rotling spot (only while #ci < #cln): a delayed rise.
execute if score #ci ch.tmp >= #cln ch.tmp run return 0
scoreboard players add #ci ch.tmp 1
execute unless block ~ ~ ~ #ch:passable positioned ~ ~1 ~ run return run function ch:kit/corruption/pan/ring_later
function ch:kit/corruption/pan/ring_later
