# A shard shatters; with Splinter it bursts into fragments that cut everything within 2.5 blocks.
particle minecraft:block{block_state:"minecraft:ice"} ~ ~ ~ 0.15 0.15 0.15 0.1 14
particle minecraft:snowflake ~ ~ ~ 0.2 0.2 0.2 0.05 8
function ch:api/fx/sprite {model:"star",color:15924223,s0:0.3,s1:1.6,t:3,life:5,spin:170,dy:0.0}
playsound minecraft:block.glass.break player @a ~ ~ ~ 0.6 1.6
scoreboard players set #f_own ch.tmp 0
execute unless entity @a[tag=ch.caster,limit=1] run scoreboard players set #f_own ch.tmp 1
execute if score #f_own ch.tmp matches 1 run function ch:api/tag_owner
execute if entity @a[tag=ch.caster,scores={ch.active=5,ch.b2=2..},limit=1] run function ch:kit/frozen/shard/splinter
execute if score #f_own ch.tmp matches 1 run tag @a remove ch.caster
