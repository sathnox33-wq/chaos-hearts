# As the Titan: drop the lifted rock and throw (one, or three with World Breaker; Up lobs it skyward).
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
execute as @e[type=block_display,tag=ch.titan.lift,distance=..6] if score @s ch.owner = #ti_pid ch.tmp run kill @s
playsound minecraft:entity.player.attack.knockback player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.iron_golem.attack player @a ~ ~ ~ 1 0.6
function ch:api/fx/slash {color:13214812,s:2.4,roll:-30,t:3}
execute if score #ti_x ch.tmp matches 1 run return run function ch:kit/titan/rock/lob
data modify storage ch:tmp trk.y set value 0
data modify storage ch:tmp trk.p set value -10
function ch:kit/titan/rock/fire
execute if score @s ch.b3 matches 5.. run data modify storage ch:tmp trk.y set value -12
execute if score @s ch.b3 matches 5.. run function ch:kit/titan/rock/fire
execute if score @s ch.b3 matches 5.. run data modify storage ch:tmp trk.y set value 12
execute if score @s ch.b3 matches 5.. run function ch:kit/titan/rock/fire
