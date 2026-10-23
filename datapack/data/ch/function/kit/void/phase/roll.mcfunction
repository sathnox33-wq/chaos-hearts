# As a projectile near a Void holder: one roll to phase through them (never their own shots).
tag @s add ch.void.rolled
execute on origin if entity @s[tag=ch.void.me] run return 0
execute if entity @s[type=item_display] if score @s ch.owner = #vme ch.tmp run return 0
execute store result score #vr ch.tmp run random value 1..100
scoreboard players set #vch ch.tmp 15
execute if entity @a[tag=ch.void.me,scores={ch.b3=3..},limit=1] run scoreboard players set #vch ch.tmp 30
execute if score #vr ch.tmp > #vch ch.tmp run return 0
execute as @a[tag=ch.void.me,limit=1] at @s run function ch:kit/void/phase/fx
kill @s
