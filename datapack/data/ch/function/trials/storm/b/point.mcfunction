# A marker at a point of the arena floor: $(d) blocks from the centre at angle $(a).
kill @e[type=marker,tag=ch.storm.pt,distance=..80]
$execute at @e[type=marker,tag=ch.session,distance=..80,limit=1] rotated $(a) 0 positioned ^ ^ ^$(d) run summon minecraft:marker ~ ~ ~ {Tags:["ch.storm.pt","ch.tmob","ch.noability"]}
