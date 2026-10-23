# Blood Spike. Level: hurl a spike of blood that wounds (6), bleeds and feeds you; three with Spike Volley; at full
# Vitae it becomes a piercing Hemorrhage Lance. Up: Crimson Rain, mark a circle where you look; a second later it
# rains spikes three times. Down: Blood Thorns, a line of thorns erupts from the ground ahead, rooting what it skewers.
execute if score #var ch.tmp matches 1 run return run function ch:kit/blood/spike/rain
execute if score #var ch.tmp matches 2 run return run function ch:kit/blood/spike/thorns
execute if score @s ch.blood.vit matches 100.. run return run function ch:kit/blood/spike/lance
function ch:kit/blood/spike/throw
execute if score @s ch.b2 matches 2.. run function ch:kit/blood/spike/volley
execute anchored eyes positioned ^ ^ ^0.8 run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.15 0.15 0.15 0.1 14
playsound chaoshearts:blood_spike player @a ~ ~ ~ 1 1
playsound minecraft:item.trident.throw player @a ~ ~ ~ 1 0.6
return 1
