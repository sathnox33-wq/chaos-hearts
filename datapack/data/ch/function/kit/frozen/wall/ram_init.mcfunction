# As a new ram block: packed ice, facing the charge, 18 ticks of life (bottom blocks do the hitting).
tp @s ~ ~ ~ ~ ~
data merge entity @s {teleport_duration:1,brightness:{sky:15,block:13},block_state:{Name:"minecraft:packed_ice"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.5f,0f,-0.5f],scale:[1f,1f,1f]}}
tag @s add ch.frozen.ram
tag @s add ch.noability
scoreboard players operation @s ch.owner = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players set @s ch.life 18
scoreboard players operation @s ch.v1 = #f_h ch.tmp
