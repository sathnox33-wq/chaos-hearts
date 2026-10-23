# At a cast: with full Heat the ability is Overheated (+40% damage for 3 s) in a white-hot flash.
execute unless score @s ch.infernal.heat matches 100.. run return 0
scoreboard players set @s ch.infernal.heat 0
scoreboard players set @s ch.infernal.ovh 60
function ch:api/fx/orb {color:16773577,s:3.5,t:3,life:7}
execute rotated 0 0 run function ch:api/fx/wave {color:16773577,r:4.0,t:5}
function ch:api/fx/screen {o:"flash",color:"#FFF1C9",in:0,stay:2,out:8}
function ch:api/fx/text {text:"OVERHEAT",color:"#FFF1C9"}
playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 1.2 0.5
playsound chaoshearts:infernal_burst player @a ~ ~ ~ 1 0.8
particle minecraft:end_rod ~ ~1 ~ 0.3 0.3 0.3 0.5 40
