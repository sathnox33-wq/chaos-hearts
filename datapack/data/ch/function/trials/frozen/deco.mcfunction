# A decoration following Hrimvald (run as it; the boss is ch.frozen.bself).
scoreboard players operation #fa ch.tmp = #now ch.g
scoreboard players set #f_k ch.tmp 6
scoreboard players operation #fa ch.tmp *= #f_k ch.tmp
scoreboard players operation #fb ch.tmp = @s ch.v1
scoreboard players set #f_k ch.tmp 72
execute if score @s ch.v1 matches 5..7 run scoreboard players set #f_k ch.tmp 120
scoreboard players operation #fb ch.tmp *= #f_k ch.tmp
scoreboard players operation #fa ch.tmp += #fb ch.tmp
scoreboard players set #f_k ch.tmp 360
scoreboard players operation #fa ch.tmp %= #f_k ch.tmp
execute if score @s ch.v1 matches 0..9 store result entity @s Rotation[0] float 1 run scoreboard players get #fa ch.tmp
execute if score @s ch.v1 matches 0..4 at @e[tag=ch.frozen.bself,limit=1] rotated as @s rotated ~ 0 positioned ^ ^4.2 ^0.3 run tp @s ~ ~ ~ ~ -10
execute if score @s ch.v1 matches 5..7 at @e[tag=ch.frozen.bself,limit=1] rotated as @s rotated ~ 0 positioned ^ ^2.4 ^2.2 run tp @s ~ ~ ~
execute if score @s ch.v1 matches 8 at @e[tag=ch.frozen.bself,limit=1] rotated ~ 0 positioned ^ ^3.6 ^-0.7 run tp @s ~ ~ ~ ~ 90
execute if score @s ch.v1 matches 9 at @e[tag=ch.frozen.bself,limit=1] run tp @s ~ ~0.1 ~
