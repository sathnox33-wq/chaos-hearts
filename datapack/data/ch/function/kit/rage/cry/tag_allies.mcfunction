# Shared Fury: players near you who are not fighting you count as teammates.
execute as @a[distance=0.01..10.4,gamemode=!spectator] unless score @s ch.opp = #me ch.tmp run tag @s add ch.rage.ally
execute as @a[tag=ch.rage.ally] if score @s ch.ctag > #now ch.g if score @s ch.opp = #me ch.tmp run tag @s remove ch.rage.ally
