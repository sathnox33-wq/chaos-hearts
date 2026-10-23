# The charge: 20 ticks of wind-up, then 14 ticks of rushing 1.6 blocks a tick.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run function ch:trials/infernal/dash_end
execute if score @s ch.life matches 15.. at @e[tag=ch.infernal.bself,limit=1] run particle minecraft:flame ~ ~1.5 ~ 0.5 1 0.5 0.06 8
execute if score @s ch.life matches 15.. run return 0
execute positioned ^ ^ ^1.6 unless block ~ ~0.5 ~ #ch:passable run return run function ch:trials/infernal/dash_end
execute positioned ^ ^ ^1.6 unless block ~ ~1.5 ~ #ch:passable run return run function ch:trials/infernal/dash_end
tp @s ^ ^ ^1.6
tp @e[tag=ch.infernal.bself,limit=1] @s
execute at @s run particle minecraft:flame ~ ~1 ~ 0.6 0.8 0.6 0.08 20
execute at @s run particle minecraft:large_smoke ~ ~1 ~ 0.4 0.5 0.4 0.02 6
execute at @s run function ch:api/fx/sprite3 {model:"flame",color:16742938,a:"[1.5,0.5,1.5]",b:"[2.0,3.5,2.0]",t:3,life:8,spin:90}
execute at @s if score @s ch.life matches 14 run playsound minecraft:entity.blaze.shoot master @a[distance=..60] ~ ~ ~ 2 0.5
execute at @s as @a[tag=ch.challenger,tag=!ch.infernal.dh,distance=..2.4] at @s run function ch:trials/infernal/dash_hit
