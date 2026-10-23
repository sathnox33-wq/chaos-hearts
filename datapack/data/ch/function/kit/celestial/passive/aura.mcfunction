# Aura (mastery 90): motes of starlight drift around the Celestial; at night they glitter brighter.
particle minecraft:end_rod ~ ~1 ~ 0.45 0.65 0.45 0.005 1
particle minecraft:dust{color:[1.0,0.949,0.69],scale:0.6} ~ ~1.1 ~ 0.5 0.7 0.5 0 2
execute if score #t20 ch.g matches 0 run particle minecraft:firework ~ ~1.6 ~ 0.4 0.4 0.4 0.01 2
