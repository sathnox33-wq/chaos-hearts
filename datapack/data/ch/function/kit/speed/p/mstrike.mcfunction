# Momentum strike: heavy knockback now, and the sonic boom of the blow lands half a second later.
scoreboard players set @s ch.speed.spr 0
scoreboard players set #d ch.speed.g 40
execute if score @s ch.b1 matches 4.. run scoreboard players set #d ch.speed.g 64
scoreboard players operation #pid ch.speed.g = @s ch.pid
execute as @e[tag=ch.victim,limit=1] at @s run function ch:kit/speed/p/mstrike_v
scoreboard players add @s ch.speed.mom 1
execute if score @s ch.speed.mom matches 25.. run function ch:api/feat {h:"speed",n:3}
function ch:api/fx/screen {o:"speed",color:"#F5E142",in:0,stay:3,out:8}
playsound chaoshearts:speed_momentum player @a ~ ~ ~ 1 1
playsound minecraft:item.trident.riptide_1 player @a ~ ~ ~ 0.8 1.4
