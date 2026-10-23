# Celestial, every tick for its holder: Starlight, Starlit and Radiance, the beam channel, Ascension, the halo.
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
scoreboard players operation #ce_t4 ch.tmp = #now ch.g
scoreboard players operation #ce_t4 ch.tmp %= #4 ch.g
execute if score #t20 ch.g matches 0 run function ch:kit/celestial/passive/second
scoreboard players operation #ce_m ch.tmp = #now ch.g
scoreboard players operation #ce_m ch.tmp %= #80 ch.celestial.k
execute if score #ce_m ch.tmp matches 0 if score @s ch.lvl matches 25.. run function ch:kit/celestial/passive/radiance
execute if score @s ch.celestial.sl matches 101.. run scoreboard players set @s ch.celestial.sl 100
execute if score @s ch.celestial.sl matches 100.. unless score @s ch.celestial.full matches 1 run function ch:kit/celestial/passive/full
scoreboard players operation @s ch.meter = @s ch.celestial.sl
execute if score @s ch.celestial.bm matches 1.. run function ch:kit/celestial/beam/channel
execute if score @s ch.celestial.asc matches 1.. run function ch:kit/celestial/asc/tick
execute if score @s ch.awake matches 1 run function ch:kit/celestial/fx/halo
execute if score #ce_t4 ch.tmp matches 0 if score @s ch.lvl matches 90.. run function ch:kit/celestial/passive/aura
