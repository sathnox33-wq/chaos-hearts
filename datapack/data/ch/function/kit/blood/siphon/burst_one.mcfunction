# One victim's blood is ripped out.
scoreboard players operation #sd2 ch.tmp = @s ch.blood.bleed
scoreboard players operation #sd2 ch.tmp *= #3 ch.blood.g
scoreboard players operation #sd2 ch.tmp /= #4 ch.g
scoreboard players add #sd2 ch.tmp 10
scoreboard players set @s ch.blood.bleed 0
execute store result storage ch:tmp blood.d int 1 run scoreboard players get #sd2 ch.tmp
function ch:kit/blood/spike/dmg with storage ch:tmp blood
scoreboard players operation #dsum ch.tmp += #sd2 ch.tmp
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:10357535,s:2.2,t:2,life:5}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16723263,s0:0.4,s1:3.0,t:3,life:6,spin:120,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.5 0.5 0.5 0.4 50
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 1.2 0.5
execute if entity @s[type=player] run function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:4,out:12}
