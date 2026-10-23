# A Siphon draught: 1.5 damage (Open Veins applies) and the caster drinks the same; Bloodbank banks overflow.
scoreboard players set #sd2 ch.tmp 15
execute if score @a[tag=ch.caster,limit=1] ch.b2 matches 3.. if score @s ch.blood.bleed matches 1.. run function ch:kit/blood/spike/veins
execute store result storage ch:tmp blood.d int 1 run scoreboard players get #sd2 ch.tmp
scoreboard players set #hits ch.tmp 0
function ch:kit/blood/spike/dmg with storage ch:tmp blood
execute positioned ~ ~1 ~ run function ch:api/fx/sprite {model:"orb",color:10357535,s0:0.8,s1:0.1,t:6,life:7,spin:120,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.2 0.3 0.2 0.1 8
playsound minecraft:item.honey_bottle.drink player @a ~ ~ ~ 0.6 0.6
execute if score #hits ch.tmp matches 1.. as @a[tag=ch.caster,limit=1] at @s run function ch:kit/blood/siphon/gain
