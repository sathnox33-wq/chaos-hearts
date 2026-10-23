# Projectiles crawl inside the field (arrows hang in the air; other hearts' ability projectiles slow to a creep).
$execute as @e[type=#minecraft:impact_projectiles,tag=!ch.speed.pz,distance=..$(r),limit=20] run function ch:kit/speed/frac/proj
$execute as @e[type=item_display,tag=ch.proj,distance=..$(r)] unless score @s ch.owner = #fo ch.speed.g run scoreboard players set @s ch.v1 1
