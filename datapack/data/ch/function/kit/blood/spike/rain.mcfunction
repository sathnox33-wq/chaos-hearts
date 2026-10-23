# Crimson Rain (Blood Spike, looking up): marks a circle where you look (up to 18 blocks, on the ground); after
# 16 ticks it rains blood spikes three times, 2.5 damage and a bleed each, 10 ticks apart. Step out of the circle!
function ch:api/ray {range:18}
execute as @e[type=marker,tag=ch.rayend,limit=1] at @s run function ch:kit/blood/spike/rain_at
playsound minecraft:entity.evoker.cast_spell player @a ~ ~ ~ 1 0.7
playsound chaoshearts:blood_spike player @a ~ ~ ~ 0.8 0.6
execute anchored eyes positioned ^ ^ ^1 run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.2 0.2 0.2 0.3 20
return 1
