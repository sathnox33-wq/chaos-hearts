# Frozen by the blizzard.
scoreboard players set @s ch.frozen.tc 0
function ch:trials/frozen/callout {t:"You froze! Keep moving!"}
function ch:trials/frozen/hit {d:40}
function ch:api/stun {t:30}
summon minecraft:block_display ~ ~ ~ {Tags:["ch.fx","ch.tmob","ch.noability","ch.frozen.snew"],brightness:{sky:15,block:12},block_state:{Name:"minecraft:ice"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.6f,0f,-0.6f],scale:[1.2f,2.1f,1.2f]}}
scoreboard players set @e[type=block_display,tag=ch.frozen.snew,limit=1] ch.life 30
tag @e[type=block_display,tag=ch.frozen.snew] remove ch.frozen.snew
scoreboard players set #fx ch.g 1
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.3 0.6 0.3 0.1 30
playsound minecraft:entity.player.hurt_freeze master @a[distance=..30] ~ ~ ~ 1 0.8
playsound minecraft:block.glass.place master @a[distance=..30] ~ ~ ~ 1 0.6
