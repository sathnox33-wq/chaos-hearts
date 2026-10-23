# Impact: a splash of bile and the plague cloud.
playsound minecraft:entity.splash_potion.break player @a ~ ~ ~ 1 0.6
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 1 0.5
playsound chaoshearts:corruption_burst player @a ~ ~ ~ 0.7 1.4
particle minecraft:dust{color:[0.784,0.831,0.165],scale:2.0} ~ ~ ~ 0.6 0.6 0.6 0 30
particle minecraft:item_slime ~ ~ ~ 0.4 0.4 0.4 0.15 20
function ch:api/fx/sprite {model:"star",color:10813263,s0:0.2,s1:2.2,t:2,life:5,spin:120,dy:0.0}
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:0.3,s1:4.0,t:4,life:7,spin:150,dy:0.0}
function ch:api/fx/light {t:4}
scoreboard players operation #crad ch.tmp = @s ch.v5
scoreboard players operation #clife ch.tmp = @s ch.v3
scoreboard players set #camp ch.tmp 0
scoreboard players operation #cwit ch.tmp = @s ch.v2
execute if score @s ch.v2 matches 1 run scoreboard players set #camp ch.tmp 1
function ch:kit/corruption/cloud/spawn
execute if entity @s[tag=ch.corruption.mortar] run function ch:kit/corruption/bolt/mortar
execute if entity @s[tag=ch.corruption.rain] run function ch:kit/corruption/bolt/rain
