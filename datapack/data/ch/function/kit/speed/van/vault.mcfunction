# Hides the player's armour in a vault in the always-loaded trials chunk; the armour value is kept as a modifier.
scoreboard players operation #pid ch.speed.g = @s ch.pid
function ch:kit/speed/van/find
execute if entity @e[type=armor_stand,tag=ch.speed.vthis,limit=1] run function ch:kit/speed/van/unvault_found
execute store result score #a0 ch.speed.g run attribute @s minecraft:armor get 100
execute store result score #t0 ch.speed.g run attribute @s minecraft:armor_toughness get 100
execute in ch:trials run summon minecraft:armor_stand 2.5 64.0 2.5 {Tags:["ch.speed.vault","ch.noability","ch.speed.vnew"],NoGravity:1b,Invisible:1b,Marker:1b,Invulnerable:1b,Silent:1b}
item replace entity @e[type=armor_stand,tag=ch.speed.vnew,limit=1] armor.head from entity @s armor.head
item replace entity @s armor.head with minecraft:air
execute unless items entity @s armor.chest *[minecraft:glider] run item replace entity @e[type=armor_stand,tag=ch.speed.vnew,limit=1] armor.chest from entity @s armor.chest
execute unless items entity @s armor.chest *[minecraft:glider] run item replace entity @s armor.chest with minecraft:air
item replace entity @e[type=armor_stand,tag=ch.speed.vnew,limit=1] armor.legs from entity @s armor.legs
item replace entity @s armor.legs with minecraft:air
item replace entity @e[type=armor_stand,tag=ch.speed.vnew,limit=1] armor.feet from entity @s armor.feet
item replace entity @s armor.feet with minecraft:air
scoreboard players operation @e[type=armor_stand,tag=ch.speed.vnew,limit=1] ch.owner = @s ch.pid
tag @e[type=armor_stand,tag=ch.speed.vnew] remove ch.speed.vnew
execute store result score #a1 ch.speed.g run attribute @s minecraft:armor get 100
execute store result score #t1 ch.speed.g run attribute @s minecraft:armor_toughness get 100
scoreboard players operation #a0 ch.speed.g -= #a1 ch.speed.g
scoreboard players operation #t0 ch.speed.g -= #t1 ch.speed.g
execute store result storage ch:kspeed gh.a double 0.01 run scoreboard players get #a0 ch.speed.g
execute store result storage ch:kspeed gh.t double 0.01 run scoreboard players get #t0 ch.speed.g
function ch:kit/speed/van/ghost with storage ch:kspeed gh
