# One gulp of banked blood: 2 hearts of healing, or absorption when already full (awakened or Bloodbank).
scoreboard players remove @s ch.blood.bank 40
execute store result score #hp ch.tmp run data get entity @s Health 10
execute store result score #mh ch.tmp run attribute @s minecraft:max_health get 10
scoreboard players operation #mh ch.tmp -= #hp ch.tmp
scoreboard players set #ab ch.tmp 0
execute if score #mh ch.tmp matches ..19 if score @s ch.awake matches 1 run scoreboard players set #ab ch.tmp 1
execute if score #mh ch.tmp matches ..19 if score #bk ch.tmp matches 1 run scoreboard players set #ab ch.tmp 1
execute if score #ab ch.tmp matches 1 run effect give @s minecraft:absorption 30 0 true
execute if score #ab ch.tmp matches 0 run function ch:api/heal {n:4}
particle minecraft:dust{color:[0.62,0.04,0.12],scale:1.6} ~ ~1.2 ~ 0.4 0.4 0.4 0 16
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.8 ~ 0.3 0.1 0.3 0 6
playsound chaoshearts:blood_drink player @a ~ ~ ~ 0.6 1.2
