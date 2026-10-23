# Hellfire (awakened): soul fire gnaws at a burning enemy for 1 extra damage.
function ch:api/hit {d:10}
particle minecraft:soul_fire_flame ~ ~1 ~ 0.25 0.5 0.25 0.03 10
particle minecraft:soul ~ ~1.2 ~ 0.2 0.3 0.2 0.02 2
function ch:api/fx/sprite {model:"flame",color:4186344,s0:0.4,s1:1.3,t:4,life:8,spin:90,dy:0.4}
