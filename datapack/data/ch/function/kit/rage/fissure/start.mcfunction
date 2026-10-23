# Earthsplitter (Rage Leap, looking down): plant your feet, raise the fist (5 ticks, a red line shows the path),
# then a fissure rips 11 blocks forward, launching and wounding everything on it.
summon marker ~ ~ ~ {Tags:["ch.rage.fis","ch.rage.fnew","ch.noability"]}
execute rotated ~ 0 run tp @e[type=marker,tag=ch.rage.fnew,limit=1] ~ ~ ~ ~ 0
scoreboard players set @e[type=marker,tag=ch.rage.fnew,limit=1] ch.v1 5
scoreboard players set @e[type=marker,tag=ch.rage.fnew,limit=1] ch.v2 0
scoreboard players operation @e[type=marker,tag=ch.rage.fnew,limit=1] ch.owner = @s ch.pid
execute as @e[type=marker,tag=ch.rage.fnew,limit=1] run function ch:api/new_eid
scoreboard players set #fd ch.tmp 55
execute if score @s ch.b1 matches 1.. run scoreboard players set #fd ch.tmp 66
scoreboard players operation @e[type=marker,tag=ch.rage.fnew,limit=1] ch.v3 = #fd ch.tmp
tag @e[type=marker,tag=ch.rage.fnew] remove ch.rage.fnew
effect give @s minecraft:slowness 1 3 true
scoreboard players set #ln ch.tmp 12
execute rotated ~ 0 positioned ~ ~0.15 ~ run function ch:kit/rage/fissure/line
execute anchored eyes positioned ^-0.4 ^-0.2 ^0.4 run particle minecraft:flame ~ ~ ~ 0.1 0.1 0.1 0.02 12
execute anchored eyes positioned ^-0.4 ^-0.2 ^0.4 run particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.5} ~ ~ ~ 0.1 0.1 0.1 0 10
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1 1.6
playsound minecraft:item.mace.smash_air player @a ~ ~ ~ 1 0.6
