# Shade Ambush: the target is rooted and the strike echoes as a sonic boom.
scoreboard players set #d ch.speed.g 60
execute if score @s ch.b1 matches 4.. run scoreboard players set #d ch.speed.g 80
scoreboard players operation #pid ch.speed.g = @s ch.pid
execute as @e[tag=ch.victim,limit=1] at @s run function ch:kit/speed/van/ambush_v
playsound chaoshearts:speed_dash player @a ~ ~ ~ 1 0.6
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1 0.7
function ch:api/fx/screen {o:"speed",color:"#29D3F2",in:0,stay:3,out:8}
