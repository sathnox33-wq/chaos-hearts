# A burning enemy died: Cremation progress, and Phoenix Ember heals 1 heart.
scoreboard players add @s ch.infernal.burnk 1
execute if score @s ch.infernal.burnk matches 20.. run function ch:api/feat {h:"infernal",n:0}
execute unless score @s ch.b3 matches 2.. run return 0
function ch:api/heal {n:2}
particle minecraft:dust{color:[1.0,0.82,0.25],scale:1.2} ~ ~1 ~ 0.6 0.8 0.6 0 24
function ch:api/fx/sprite {model:"feather",color:16765503,s0:0.2,s1:1.4,t:6,life:12,spin:170,dy:1.2}
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.8 1.4
