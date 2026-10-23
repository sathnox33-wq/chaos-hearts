# Storm aura (mastery 90): sparks crawl over you; awakened, small arcs leap off your shoulders.
particle minecraft:electric_spark ~ ~1 ~ 0.4 0.6 0.4 0.05 1
execute if score #t20 ch.g matches 0..2 run particle minecraft:dust{color:[0.31,0.66,1.0],scale:0.7} ~ ~2.3 ~ 0.4 0.05 0.4 0 3
execute if score #t20 ch.g matches 0..2 positioned ~ ~2.4 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"cloud",color:7241632,s0:0.3,s1:0.8,t:10,life:18,spin:90,dy:0.3}
execute if score @s ch.awake matches 1 if score #t20 ch.g matches 9..11 positioned ~ ~1.5 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"bolt",color:15267583,s0:0.2,s1:0.7,t:2,life:5,spin:170,dy:0.0}
execute if score @s ch.awake matches 1 if score #t20 ch.g matches 9..11 run particle minecraft:electric_spark ~ ~1.5 ~ 0.6 0.4 0.6 0.4 6
