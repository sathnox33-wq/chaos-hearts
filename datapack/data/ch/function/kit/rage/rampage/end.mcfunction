# Rampage burns out.
scoreboard players set @s ch.rage.rv 0
particle minecraft:large_smoke ~ ~1 ~ 0.4 0.6 0.4 0.03 20
function ch:api/fx/wave {color:3801088,r:3.0,t:6}
playsound minecraft:entity.ravager.stunned player @a ~ ~ ~ 0.6 0.8
