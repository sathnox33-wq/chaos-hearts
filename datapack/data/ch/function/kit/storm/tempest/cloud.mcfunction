# The thundercloud that follows the caster: dark churning dust, rain and veins of light.
particle minecraft:dust{color:[0.25,0.28,0.36],scale:3.0} ~ ~6 ~ 3.5 0.3 3.5 0 14
particle minecraft:cloud ~ ~6.3 ~ 3 0.2 3 0.01 6
particle minecraft:falling_water ~ ~5.5 ~ 3.5 0.1 3.5 0 10
execute if score #t10 ch.storm.g matches 0 positioned ~ ~6 ~ rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:7241632,s0:9.0,s1:10.0,t:10,life:12,spin:60,dy:0.0}
execute if score #t5 ch.storm.g matches 0 run particle minecraft:electric_spark ~ ~5.8 ~ 3 0.2 3 0.3 10
execute if score #t10 ch.storm.g matches 5 run playsound minecraft:weather.rain player @a ~ ~ ~ 0.4 0.8
