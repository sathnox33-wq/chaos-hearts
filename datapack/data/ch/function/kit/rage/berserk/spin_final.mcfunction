# The last Ravage spin ends in a burst of fire.
function ch:api/fx/wave {color:14689835,r:4.2,t:5}
particle minecraft:flame ~ ~0.6 ~ 2 0.3 2 0.1 40
particle minecraft:explosion ~ ~0.8 ~ 1.5 0.2 1.5 0 3
function ch:api/fx/shake {s:2,t:6,r:8}
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.7 1.1
