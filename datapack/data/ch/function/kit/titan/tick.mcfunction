# Titan, every tick for its holder: Tremor meter, passives, Stone Skin, Colossus and airborne slams.
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
scoreboard players operation #ti_t4 ch.tmp = #now ch.g
scoreboard players operation #ti_t4 ch.tmp %= #4 ch.g
execute if score #t20 ch.g matches 0 run function ch:kit/titan/passive/second
execute if score #ti_t4 ch.tmp matches 0 if score @s ch.lvl matches 25.. run function ch:kit/titan/passive/bulwark
execute if score @s ch.titan.trem matches 101.. run scoreboard players set @s ch.titan.trem 100
execute if score @s ch.titan.trem matches 100.. unless score @s ch.titan.full matches 1 run function ch:kit/titan/passive/full
scoreboard players operation @s ch.meter = @s ch.titan.trem
execute if score @s ch.titan.thcd matches 1.. run scoreboard players remove @s ch.titan.thcd 1
execute if score @s ch.titan.skin matches 1.. run function ch:kit/titan/skin/tick
execute if score @s ch.titan.grow matches 1.. run function ch:kit/titan/col/grow_step
execute if score @s ch.titan.col matches 1.. run function ch:kit/titan/col/tick
execute if score @s ch.titan.air matches 1.. run function ch:kit/titan/slam/air
execute if score @s ch.titan.fall matches 1.. run function ch:kit/titan/passive/fall
execute if score #ti_t4 ch.tmp matches 0 if score @s ch.lvl matches 90.. run function ch:kit/titan/passive/aura
scoreboard players set @s ch.titan.res 0
