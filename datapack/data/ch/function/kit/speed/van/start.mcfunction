# You vanish: invisible, armour hidden in the vault (its protection kept), Speed II.
function ch:kit/speed/van/vault
scoreboard players operation @s ch.speed.van = #dur ch.speed.g
scoreboard players operation #s ch.speed.g = #dur ch.speed.g
scoreboard players add #s ch.speed.g 19
scoreboard players operation #s ch.speed.g /= #20 ch.g
execute store result storage ch:kspeed ve.s int 1 run scoreboard players get #s ch.speed.g
function ch:kit/speed/van/effects with storage ch:kspeed ve
particle minecraft:cloud ~ ~1 ~ 0.4 0.6 0.4 0.05 25
particle minecraft:dust_color_transition{from_color:[0.96,0.88,0.26],to_color:[0.16,0.83,0.95],scale:1.3} ~ ~1 ~ 0.4 0.7 0.4 0 30
execute positioned ~ ~1 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"swirl",color:16113986,s0:2.0,s1:0.1,t:6,life:8,spin:170,dy:0.0}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:2741234,s0:2.6,s1:0.1,t:5,life:7,spin:0,dy:0.0}
function ch:api/fx/orb {color:16777215,s:1.2,t:2,life:4}
playsound chaoshearts:speed_afterimage player @a ~ ~ ~ 1 1
playsound minecraft:entity.illusioner.cast_spell player @a ~ ~ ~ 0.9 1.5
function ch:api/fx/screen {o:"speed",color:"#29D3F2",in:1,stay:4,out:12}
execute if score @s ch.speed.vmode matches 2 run title @s subtitle {text:"Strike from the shadows",color:"#29D3F2",italic:true}
execute if score @s ch.speed.vmode matches 1 run title @s subtitle {text:"Mirror Feint",color:"#F5E142",italic:true}
