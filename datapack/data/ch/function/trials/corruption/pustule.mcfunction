# One pustule: a slime-block lump that swells for 40 ticks over a closing ring.
summon block_display ~-0.5 ~ ~-0.5 {Tags:["ch.tmob","ch.noability","ch.corruption.tpus"],block_state:{Name:"minecraft:slime_block"},brightness:{sky:15,block:12},interpolation_duration:40,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0.3f,0f,0.3f],scale:[0.4f,0.4f,0.4f]}}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:6.5,s1:1.0,t:40,life:41,spin:170,dy:0.0}
playsound minecraft:entity.slime.squish hostile @a ~ ~ ~ 1 0.5
function ch:api/later {t:2,then:"ch:trials/corruption/pustule_grow"}
function ch:api/later {t:40,then:"ch:trials/corruption/pustule_pop"}
