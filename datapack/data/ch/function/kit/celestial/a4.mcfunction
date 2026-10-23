# Ascension. Level: rise and hover, shielded by light, as stars hunt your foes. Up: Zenith, soar higher and call
# each star where you look. Down: Avatar, stay grounded as a radiant avatar ringed by falling stars.
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
execute if score @s ch.celestial.asc matches 1.. run return fail
scoreboard players set @s ch.celestial.ascm 0
execute if score #var ch.tmp matches 1 run scoreboard players set @s ch.celestial.ascm 1
execute if score #var ch.tmp matches 2 run scoreboard players set @s ch.celestial.ascm 2
scoreboard players set @s ch.celestial.asc 160
execute if score @s ch.b3 matches 4.. run scoreboard players set @s ch.celestial.asc 208
scoreboard players set @s ch.celestial.age 0
scoreboard players set @s ch.celestial.sh 0
execute if score @s ch.celestial.ascm matches 0 run effect give @s minecraft:levitation 1 3 true
execute if score @s ch.celestial.ascm matches 1 run effect give @s minecraft:levitation 2 5 true
execute unless score @s ch.celestial.ascm matches 2 run effect give @s minecraft:resistance 11 2 true
execute if score @s ch.celestial.ascm matches 2 run effect give @s minecraft:resistance 11 0 true
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:1.6,h:22.0,t:5,life:16}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.6,h:26.0,t:3,life:12}
function ch:api/fx/wave {color:16773808,r:6,t:8}
execute positioned ~ ~0.05 ~ run function ch:kit/celestial/fx/sigil {model:"hex",color:16765803,s:8.0,life:40,tag:"ch.celestial.cw"}
particle minecraft:end_rod ~ ~1 ~ 0.6 1 0.6 0.3 80
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 1 0.5 0.4 40
playsound chaoshearts:celestial_ascension player @a ~ ~ ~ 2 1
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 2 0.8
playsound minecraft:item.totem.use player @a ~ ~ ~ 0.6 1.6
function ch:api/fx/shake {s:2,t:10,r:10}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:10}
execute unless score @s ch.celestial.ascm matches 2 run function ch:kit/celestial/fx/banner {o:"celestial",color:"#FFF2B0",in:2,stay:30,out:12,sub:"✦ ASCENSION ✦",subc:"#FFD36B"}
execute if score @s ch.celestial.ascm matches 2 run function ch:kit/celestial/fx/banner {o:"celestial",color:"#FFF2B0",in:2,stay:30,out:12,sub:"✦ AVATAR OF THE STARS ✦",subc:"#FFD36B"}
return 1
