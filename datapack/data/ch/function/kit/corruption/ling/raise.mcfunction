# Raises a Rotling here for the caster (life #cll): a small, rotting husk that hunts the caster's enemies.
summon husk ~ ~ ~ {Tags:["ch.corruption.ling","ch.corruption.lnew","ch.noability"],NoAI:1b,PersistenceRequired:1b,DeathLootTable:"minecraft:empty",CustomName:{text:"Rotling",color:"#7BD13A"},attributes:[{id:"minecraft:scale",base:0.85},{id:"minecraft:max_health",base:20.0}],Health:20f,equipment:{head:{id:"minecraft:moss_carpet",count:1}},drop_chances:{head:0.0f,mainhand:0.0f}}
execute as @e[type=husk,tag=ch.corruption.lnew,limit=1] run function ch:kit/corruption/ling/init
particle minecraft:dust{color:[0.239,0.102,0.322],scale:1.8} ~ ~1 ~ 0.4 0.8 0.4 0 30
particle minecraft:block{block_state:"minecraft:rooted_dirt"} ~ ~0.3 ~ 0.4 0.2 0.4 0 30
particle minecraft:sculk_soul ~ ~0.5 ~ 0.3 0.3 0.3 0.04 6
execute rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:8114490,s0:0.3,s1:3.0,t:5,life:8,spin:150,dy:0.0}
playsound minecraft:entity.zombie.ambient player @a ~ ~ ~ 1 0.6
playsound minecraft:block.rooted_dirt.break player @a ~ ~ ~ 1 0.7
