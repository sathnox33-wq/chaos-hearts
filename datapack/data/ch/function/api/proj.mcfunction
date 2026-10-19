# As the caster: fires an item_display projectile from the eyes along the look direction.
# item: the item it shows, scale: its size, speed: quarter blocks per tick (4 = 20 blocks a second), life: ticks,
# hit/step/end: functions run at the projectile with the owner tagged ch.caster (hit also tags what it hit ch.target),
# pierce: 1 to keep flying through targets, ignore: tag of entities it passes through ("ch.powner" skips its owner).
$execute anchored eyes positioned ^ ^ ^0.6 run summon item_display ~ ~ ~ {Tags:["ch.proj","ch.pnew"],teleport_duration:1,brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]},item:{id:"$(item)",count:1,components:{"minecraft:custom_data":{hit:"$(hit)",step:"$(step)",end:"$(end)",pierce:$(pierce),ignore:"$(ignore)",id:0}}}}
execute anchored eyes positioned ^ ^ ^0.6 rotated as @s run tp @e[type=item_display,tag=ch.pnew,limit=1] ~ ~ ~ ~ ~
function ch:api/proj_init
