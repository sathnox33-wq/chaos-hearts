# Once a second: Pain Tolerance (10% less damage below half health, via armour) and the Vitae meter.
scoreboard players set #lo ch.tmp 0
execute store result score #hp ch.tmp run data get entity @s Health 10
execute store result score #mh ch.tmp run attribute @s minecraft:max_health get 5
execute if score @s ch.b3 matches 3.. if score #hp ch.tmp < #mh ch.tmp run scoreboard players set #lo ch.tmp 1
execute if score #lo ch.tmp matches 1 unless score @s ch.blood.tol matches 1 run function ch:kit/blood/tol_on
execute if score #lo ch.tmp matches 0 if score @s ch.blood.tol matches 1 run function ch:kit/blood/tol_off
scoreboard players operation @s ch.meter = @s ch.blood.vit
