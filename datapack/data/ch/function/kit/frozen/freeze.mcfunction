# As a target, caster tagged: freezes it solid for #f_ft ticks (+50% with Frozen Solid): rooted, slowed, encased in ice.
execute if entity @s[type=player,scores={ch.active=5}] run return fail
execute if entity @a[tag=ch.caster,scores={ch.active=5,ch.b1=4..},limit=1] run function ch:kit/frozen/freeze_long
execute store result storage ch:tmp kf.t int 1 run scoreboard players get #f_ft ch.tmp
execute store result score #f_ok ch.tmp run function ch:api/stun with storage ch:tmp kf
execute if score #f_ok ch.tmp matches 0 run return fail
effect give @s[type=!player] minecraft:slowness 2 3 true
tag @s add ch.frozen.solid
scoreboard players operation @s ch.frozen.fz = #f_ft ch.tmp
execute unless entity @s[type=player] run data modify entity @s TicksFrozen set value 300
summon minecraft:block_display ~ ~ ~ {Tags:["ch.fx","ch.noability","ch.frozen.shell","ch.frozen.snew"],brightness:{sky:15,block:12},block_state:{Name:"minecraft:ice"},interpolation_duration:3,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.65f,-0.05f,-0.65f],scale:[1.3f,2.25f,1.3f]}}
scoreboard players operation @e[type=block_display,tag=ch.frozen.snew,limit=1] ch.life = #f_ft ch.tmp
scoreboard players add @e[type=block_display,tag=ch.frozen.snew,limit=1] ch.life 3
tag @e[type=block_display,tag=ch.frozen.snew] remove ch.frozen.snew
scoreboard players set #fx ch.g 1
execute rotated 0 0 positioned ~ ~0.05 ~ run function ch:api/fx/sprite {model:"crack",color:10217471,s0:0.5,s1:2.6,t:4,life:30,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.3 0.5 0.3 0.1 30
particle minecraft:snowflake ~ ~1 ~ 0.4 0.6 0.4 0.05 20
playsound minecraft:block.glass.break player @a ~ ~ ~ 0.8 1.4
playsound minecraft:entity.player.hurt_freeze player @a ~ ~ ~ 0.8 0.8
execute if entity @s[type=player] run function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:1,stay:24,out:16}
return 1
