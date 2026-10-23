# A decoration following Ignaroth (run as it; the boss is ch.infernal.bself).
scoreboard players operation #ia ch.tmp = #now ch.g
scoreboard players set #i_k ch.tmp 7
scoreboard players operation #ia ch.tmp *= #i_k ch.tmp
scoreboard players operation #ib ch.tmp = @s ch.v1
scoreboard players set #i_k ch.tmp 120
scoreboard players operation #ib ch.tmp *= #i_k ch.tmp
scoreboard players operation #ia ch.tmp += #ib ch.tmp
scoreboard players set #i_k ch.tmp 360
scoreboard players operation #ia ch.tmp %= #i_k ch.tmp
execute if score @s ch.v1 matches 4..7 store result entity @s Rotation[0] float 1 run scoreboard players get #ia ch.tmp
execute if score @s ch.v1 matches 0 at @e[tag=ch.infernal.bself,limit=1] rotated ~ 0 positioned ^ ^3.9 ^ run tp @s ~ ~ ~ ~ 0
execute if score @s ch.v1 matches 1 at @e[tag=ch.infernal.bself,limit=1] rotated ~ 0 positioned ^0.35 ^3.75 ^ run tp @s ~ ~ ~ ~ -15
execute if score @s ch.v1 matches 2 at @e[tag=ch.infernal.bself,limit=1] rotated ~ 0 positioned ^-0.35 ^3.75 ^ run tp @s ~ ~ ~ ~ 15
execute if score @s ch.v1 matches 3 at @e[tag=ch.infernal.bself,limit=1] rotated ~ 0 positioned ^ ^3.5 ^-0.6 run tp @s ~ ~ ~ ~ 90
execute if score @s ch.v1 matches 4..6 at @e[tag=ch.infernal.bself,limit=1] rotated as @s rotated ~ 0 positioned ^ ^2.2 ^2.0 run tp @s ~ ~ ~
execute if score @s ch.v1 matches 7 at @e[tag=ch.infernal.bself,limit=1] run tp @s ~ ~0.1 ~
