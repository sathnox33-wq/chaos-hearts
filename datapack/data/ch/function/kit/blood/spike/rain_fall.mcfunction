# A wave of Crimson Rain (ch.v1 = 1..3): spikes slam into the circle.
scoreboard players operation #rw ch.tmp = @s ch.v1
scoreboard players set #bt ch.tmp 40
scoreboard players set #bm ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.6] run function ch:kit/blood/spike/rain_hit
execute if score #rw ch.tmp matches 1 run function ch:kit/blood/spike/rain_fx1
execute if score #rw ch.tmp matches 2 run function ch:kit/blood/spike/rain_fx2
execute if score #rw ch.tmp matches 3 run function ch:kit/blood/spike/rain_fx1
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~5 ~ 2.5 1 2.5 0 40
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~0.3 ~ 2.5 0.1 2.5 0.2 40
playsound minecraft:block.pointed_dripstone.land player @a ~ ~ ~ 1.2 0.6
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 1 0.5
function ch:api/fx/shake {s:1,t:3,r:6}
execute if score #rw ch.tmp matches ..2 run function ch:api/later {t:10,then:"ch:kit/blood/spike/rain_fall"}
scoreboard players add #rw ch.tmp 1
execute if score #rw ch.tmp matches ..3 run scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v1 = #rw ch.tmp
