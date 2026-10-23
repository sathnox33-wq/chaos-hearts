# Executioner, as the victim: under 30% health it is rent again half a second later for 15% of the weapon's damage.
execute store result score #hp ch.tmp run data get entity @s Health 10
execute store result score #mh ch.tmp run attribute @s minecraft:max_health get 3
execute if score #hp ch.tmp >= #mh ch.tmp run return 0
execute if score #hp ch.tmp matches ..0 run return 0
execute store result score #d2 ch.tmp as @a[tag=ch.caster,limit=1] run attribute @s minecraft:attack_damage get 1.5
execute if score #d2 ch.tmp matches ..4 run scoreboard players set #d2 ch.tmp 5
execute unless score @s ch.eid matches 1.. run function ch:api/new_eid
function ch:api/later {t:11,then:"ch:kit/rage/exec/rend"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v1 = @s ch.eid
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v2 = #d2 ch.tmp
particle minecraft:dust{color:[0.55,0.0,0.02],scale:1.4} ~ ~1.2 ~ 0.2 0.3 0.2 0 10
playsound minecraft:block.chain.break player @a ~ ~ ~ 0.6 0.5
