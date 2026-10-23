# Blizzard pulses for radius $(r): whirling snow, a frost ring, chilling every 0.5 s, ice spikes every second, Heart of Winter.
scoreboard players operation #f_p ch.tmp = @s ch.v3
scoreboard players operation #f_p ch.tmp %= #2 ch.g
$execute if score #f_p ch.tmp matches 0 run particle minecraft:snowflake ~ ~2 ~ $(rs) 2 $(rs) 0.12 34
$execute if score #f_p ch.tmp matches 0 run particle minecraft:white_ash ~ ~2 ~ $(rs) 2 $(rs) 0 14
$execute if score #f_p ch.tmp matches 0 run particle minecraft:cloud ~ ~5 ~ $(rs) 0.4 $(rs) 0.01 3
scoreboard players operation #f_p ch.tmp = @s ch.v3
scoreboard players operation #f_p ch.tmp %= #4 ch.g
$execute if score #f_p ch.tmp matches 0 run function ch:api/fx/ring {p:"minecraft:dust{color:[0.61,0.91,1.0],scale:1.6}",r:$(r)}
scoreboard players operation #f_p ch.tmp = @s ch.v3
scoreboard players operation #f_p ch.tmp %= #10 ch.g
$execute if score #f_p ch.tmp matches 0 rotated 0 0 positioned ~ ~0.15 ~ run function ch:api/fx/sprite {model:"swirl",color:10217471,s0:$(dia),s1:$(dia),t:10,life:13,spin:170,dy:0.0}
$execute if score #f_p ch.tmp matches 0 rotated 0 0 positioned ~ ~6 ~ run function ch:api/fx/sprite {model:"cloud",color:15924223,s0:$(r),s1:$(dia),t:10,life:13,spin:-90,dy:0.0}
$execute if score #f_p ch.tmp matches 5 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] at @s run function ch:kit/frozen/zero/chill
scoreboard players operation #f_p ch.tmp = @s ch.v3
scoreboard players operation #f_p ch.tmp %= #20 ch.g
$execute if score #f_p ch.tmp matches 0 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r),sort=nearest,limit=3] at @s run function ch:kit/frozen/zero/spike_mark
execute if score #f_p ch.tmp matches 0 run playsound minecraft:block.powder_snow.step player @a ~ ~ ~ 1.5 0.5
$execute if entity @a[tag=ch.caster,scores={ch.b3=5..},distance=..$(r),limit=1] run effect clear @a[tag=ch.caster,limit=1] minecraft:slowness
$execute if score #f_p ch.tmp matches 0 if entity @a[tag=ch.caster,scores={ch.b3=5..},distance=..$(r),limit=1] run effect give @a[tag=ch.caster,limit=1] minecraft:regeneration 2 1 true
