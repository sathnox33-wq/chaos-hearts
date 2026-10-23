# Open Veins, as a bleeding victim: the wound tears again half a second later for 10% of the weapon's damage.
execute store result score #d2 ch.tmp as @a[tag=ch.caster,limit=1] run attribute @s minecraft:attack_damage get 1
execute if score #d2 ch.tmp matches ..2 run scoreboard players set #d2 ch.tmp 3
execute unless score @s ch.eid matches 1.. run function ch:api/new_eid
function ch:api/later {t:11,then:"ch:kit/blood/veins_rend"}
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v1 = @s ch.eid
scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v2 = #d2 ch.tmp
