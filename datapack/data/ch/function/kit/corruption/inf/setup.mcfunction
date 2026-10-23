# As the caster: loads the Contagion branch into the infection scratch (fuse, radius, damage, flags).
scoreboard players set #cgen ch.tmp 0
scoreboard players set #cfuse ch.tmp 80
execute if score @s ch.b3 matches 1.. run scoreboard players set #cfuse ch.tmp 60
scoreboard players set #crad ch.tmp 30
execute if score @s ch.b3 matches 2.. run scoreboard players set #crad ch.tmp 42
scoreboard players set #cdmg ch.tmp 60
execute store success score #cfc ch.tmp if score @s ch.b3 matches 4..
execute store success score #cfb ch.tmp if score @s ch.b3 matches 5..
execute store success score #cfa ch.tmp if score @s ch.awake matches 1
execute store success score #cnec ch.tmp if score @s ch.b1 matches 4..
scoreboard players set #cfl ch.tmp 0
scoreboard players set #cfs ch.tmp 0
