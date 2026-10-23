# Raises a Blood Moon for $(t) ticks over the caster (mv 0) or anchored here (mv 1).
$scoreboard players set @s ch.blood.moon $(t)
scoreboard players set @s ch.blood.mheal 0
$function ch:kit/blood/moon/buff {t:$(t)}
scoreboard players operation #me ch.tmp = @s ch.pid
execute as @e[tag=ch.blood.moonv,distance=..80] if score @s ch.owner = #me ch.tmp run kill @s
execute if score @s ch.blood.mv matches 0 positioned ~ ~9 ~ run function ch:kit/blood/moon/spawn
execute if score @s ch.blood.mv matches 1 run summon marker ~ ~ ~ {Tags:["ch.blood.moonv","ch.blood.mnew","ch.blood.deco","ch.noability"]}
execute if score @s ch.blood.mv matches 1 positioned ~ ~12 ~ run function ch:kit/blood/moon/spawn
execute if score @s ch.blood.mv matches 1 positioned ~ ~0.08 ~ run summon item_display ~ ~ ~ {Tags:["ch.blood.moonv","ch.blood.mnew","ch.blood.deco","ch.noability"],brightness:{sky:15,block:15},item_display:"none",interpolation_duration:10,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[28f,1f,28f]},item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"chaoshearts:fx/rune","minecraft:custom_model_data":{colors:[10357535]}}}}
scoreboard players operation @e[tag=ch.blood.mnew] ch.owner = @s ch.pid
$scoreboard players set @e[tag=ch.blood.mnew] ch.life $(t)
tag @e[tag=ch.blood.mnew] remove ch.blood.mnew
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
function ch:api/fx/wave {color:10357535,r:10.0,t:10}
function ch:api/fx/pillar {model:"beam",color:16723263,w:1.2,h:10.0,t:6,life:14}
particle minecraft:dust{color:[0.62,0.04,0.12],scale:2.5} ~ ~4 ~ 1 4 1 0 80
function ch:api/fx/shake {s:2,t:12,r:16}
function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:4,stay:10,out:20}
function ch:api/fx/text {text:"☾ THE BLOOD MOON RISES",color:"#FF2D3F"}
playsound chaoshearts:blood_moon player @a ~ ~ ~ 2 1
playsound minecraft:entity.wither.ambient player @a ~ ~ ~ 1 0.5
playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 2 0.6
tag @s add ch.caster
execute as @a[tag=!ch.caster,distance=..16,gamemode=!spectator] run function ch:kit/blood/moon/dread
tag @s remove ch.caster
