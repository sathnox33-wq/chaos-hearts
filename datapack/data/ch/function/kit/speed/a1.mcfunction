# Dash. Level: blink forward cutting all in your path. Up: Rising Rend, a diagonal cut that throws them skyward.
# Down: Recoil, dash backward and leave a ticking slash trap where you stood.
scoreboard players set #dr ch.speed.g 16
execute if score @s ch.b1 matches 2.. run scoreboard players set #dr ch.speed.g 21
execute unless score #var ch.tmp matches 0 run scoreboard players set #dr ch.speed.g 12
execute unless score #var ch.tmp matches 0 if score @s ch.b1 matches 2.. run scoreboard players set #dr ch.speed.g 16
scoreboard players set #dd ch.speed.g 40
execute if score @s ch.b1 matches 1.. run scoreboard players set #dd ch.speed.g 50
scoreboard players operation #dv ch.speed.g = #var ch.tmp
scoreboard players set #steps ch.speed.g 0
scoreboard players operation #rs ch.speed.g = #dr ch.speed.g
tag @e[tag=ch.speed.cut] remove ch.speed.cut
kill @e[type=marker,tag=ch.speed.ds,distance=..3]
summon minecraft:marker ~ ~ ~ {Tags:["ch.speed.ds","ch.noability"]}
execute if score #dv ch.speed.g matches 0 rotated ~ 0 run tp @e[type=marker,tag=ch.speed.ds,limit=1,sort=nearest] ~ ~ ~ ~ ~
execute if score #dv ch.speed.g matches 1 rotated as @s run tp @e[type=marker,tag=ch.speed.ds,limit=1,sort=nearest] ~ ~ ~ ~ ~
execute if score #dv ch.speed.g matches 2 rotated ~180 0 run tp @e[type=marker,tag=ch.speed.ds,limit=1,sort=nearest] ~ ~ ~ ~ ~
execute at @e[type=marker,tag=ch.speed.ds,limit=1,sort=nearest] rotated as @e[type=marker,tag=ch.speed.ds,limit=1,sort=nearest] run function ch:kit/speed/dash/step
execute if score #steps ch.speed.g matches ..2 run kill @e[type=marker,tag=ch.speed.ds]
execute if score #steps ch.speed.g matches ..2 run return fail
scoreboard players set @s ch.speed.dsh 60
execute as @e[tag=ch.speed.cut,distance=..16] at @s run function ch:kit/speed/dash/cut
function ch:kit/speed/dash/fx
execute if score #dv ch.speed.g matches 2 at @e[type=marker,tag=ch.speed.ds,limit=1] run function ch:kit/speed/dash/trap_set
execute if score #dv ch.speed.g matches 1 run effect give @s minecraft:slow_falling 2 0 true
kill @e[type=marker,tag=ch.speed.ds]
tag @e[tag=ch.speed.cut] remove ch.speed.cut
scoreboard players set #cd ch.speed.g 120
execute if score @s ch.awake matches 1 run scoreboard players set #cd ch.speed.g 60
execute if score #hits ch.tmp matches 1.. if score @s ch.b1 matches 3.. run scoreboard players operation #cd ch.speed.g *= #c7 ch.speed.g
execute if score #hits ch.tmp matches 1.. if score @s ch.b1 matches 3.. run scoreboard players operation #cd ch.speed.g /= #c10 ch.speed.g
execute if score #hits ch.tmp matches 1.. if score @s ch.b1 matches 3.. run playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.5 2
data modify storage ch:kspeed cd set value {slot:1,t:120}
execute store result storage ch:kspeed cd.t int 1 run scoreboard players get #cd ch.speed.g
function ch:api/cooldown with storage ch:kspeed cd
return 1
