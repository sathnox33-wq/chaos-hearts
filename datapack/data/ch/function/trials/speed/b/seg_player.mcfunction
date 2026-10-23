# The last streak runs to where the challenger is heading.
kill @e[type=marker,tag=ch.speed.pt,distance=..80]
execute as @a[tag=ch.challenger,limit=1] at @s rotated ~ 0 positioned ^ ^ ^3 positioned ~ 100 ~ run summon minecraft:marker ~ ~ ~ {Tags:["ch.speed.pt","ch.tmob","ch.noability"]}
function ch:trials/speed/b/seg
