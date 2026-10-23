# Stormborn: lightning runs straight through you (the health comes back and the flames go out).
function ch:api/heal {n:5}
effect give @s minecraft:fire_resistance 4 0 true
function ch:api/fx/text {text:"GROUNDED",color:"#4FA8FF"}
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.6 0.3 0.3 20
