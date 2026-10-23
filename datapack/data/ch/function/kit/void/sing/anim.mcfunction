# Every 5 ticks: spin and grow the display layers (they shrink fast in the last second).
scoreboard players operation #sk ch.tmp = @s ch.t
scoreboard players operation #sk ch.tmp *= #15 ch.void.k
scoreboard players operation #sk ch.tmp += #300 ch.void.k
execute if score #sk ch.tmp > #2100 ch.void.k run scoreboard players set #sk ch.tmp 2100
execute if entity @s[tag=ch.void.mini] run scoreboard players operation #sk ch.tmp /= #2 ch.g
execute if score @s ch.life matches ..20 run scoreboard players operation #sk ch.tmp = @s ch.life
execute if score @s ch.life matches ..20 run scoreboard players operation #sk ch.tmp *= #90 ch.void.k
execute store result storage ch:void s.s float 0.001 run scoreboard players get #sk ch.tmp
scoreboard players operation #sk2 ch.tmp = #sk ch.tmp
scoreboard players operation #sk2 ch.tmp *= #26 ch.void.k
execute store result storage ch:void s.s2 float 0.0001 run scoreboard players get #sk2 ch.tmp
scoreboard players operation #sk2 ch.tmp = #sk ch.tmp
scoreboard players operation #sk2 ch.tmp *= #34 ch.void.k
execute store result storage ch:void s.s3 float 0.0001 run scoreboard players get #sk2 ch.tmp
scoreboard players operation #sk2 ch.tmp = #sk ch.tmp
scoreboard players operation #sk2 ch.tmp *= #45 ch.void.k
execute store result storage ch:void s.s4 float 0.0001 run scoreboard players get #sk2 ch.tmp
execute store result storage ch:void s.a float 0.2 run scoreboard players get @s ch.t
scoreboard players operation #sk2 ch.tmp = @s ch.t
scoreboard players operation #sk2 ch.tmp *= #-1 ch.g
execute store result storage ch:void s.b float 0.3 run scoreboard players get #sk2 ch.tmp
execute as @e[type=item_display,tag=ch.void.sd,distance=..3] if score @s ch.void.sid = #sid ch.tmp run function ch:kit/void/sing/anim1 with storage ch:void s
