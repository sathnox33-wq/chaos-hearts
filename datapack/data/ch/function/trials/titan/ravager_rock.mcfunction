# The boulder that rides the Boulderback.
data merge entity @s {Tags:["ch.tmob","ch.noability"],block_state:{Name:"minecraft:mossy_cobblestone"},transformation:{left_rotation:[0.1f,0.2f,0f,0.97f],right_rotation:[0f,0f,0f,1f],translation:[-0.8f,-0.6f,-0.8f],scale:[1.6f,1.4f,1.6f]}}
ride @s mount @e[type=ravager,tag=ch.tmob,distance=..1,limit=1,sort=nearest]
