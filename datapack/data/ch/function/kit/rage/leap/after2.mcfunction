# Meteor aftermath (7 ticks later): embers rain down and the ground glows.
function ch:api/fx/wave {color:16738847,r:8.0,t:12}
particle minecraft:lava ~ ~3 ~ 3 1 3 0 25
particle minecraft:large_smoke ~ ~1 ~ 2 0.5 2 0.03 30
playsound minecraft:block.lava.extinguish player @a ~ ~ ~ 1 0.5
