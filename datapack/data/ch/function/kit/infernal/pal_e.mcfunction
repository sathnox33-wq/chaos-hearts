# Writes the flame palette of a summoned Infernal entity (ch.v6 1 = soul fire) to storage ch:tmp ki.
data modify storage ch:tmp ki set value {c:16742938,c2:9182208,c3:16765503,fl:"minecraft:flame",hex:"#FF7A1A",dc:"[1.0,0.48,0.1]",dc2:"[0.55,0.11,0.0]"}
execute if score @s ch.v6 matches 1 run data modify storage ch:tmp ki merge value {c:4186344,c2:1723035,c3:13172735,fl:"minecraft:soul_fire_flame",hex:"#3FE0E8",dc:"[0.25,0.88,0.91]",dc2:"[0.1,0.29,0.61]"}
