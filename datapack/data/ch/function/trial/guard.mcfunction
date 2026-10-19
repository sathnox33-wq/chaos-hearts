# Keeps the fight inside the arena: anything that falls out is put back (players) or removed (mobs).
execute as @a[tag=ch.challenger,distance=..200] at @s if entity @s[y=-64,dy=150] run function ch:trial/fell
kill @e[tag=ch.tmob,type=!#ch:ignore,distance=..120,y=-64,dy=150]
