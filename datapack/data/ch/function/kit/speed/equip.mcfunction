# Speed became active: Swift (+15% movement speed).
attribute @s minecraft:movement_speed modifier add ch:speed_swift 0.15 add_multiplied_total
scoreboard players set @s ch.speed.spr 0
particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~1 ~ 0.4 0.6 0.4 0 25
execute rotated ~ 0 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:0.3,s1:2.4,t:5,life:8,spin:150,dy:0.6}
playsound minecraft:item.trident.riptide_1 player @a ~ ~ ~ 0.5 1.8
