# Summons a mannequin wearing your face, name and gear where you stand.
summon minecraft:mannequin ~ ~ ~ {Tags:["ch.speed.decoy","ch.noability","ch.speed.dnew"],Invulnerable:1b,immovable:1b,hide_description:1b,Silent:1b,CustomNameVisible:1b}
execute rotated ~ 0 run tp @e[type=mannequin,tag=ch.speed.dnew,limit=1] ~ ~ ~ ~ ~
execute if entity @e[type=item_display,tag=ch.helper,limit=1] run function ch:kit/speed/van/decoy_face
item replace entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] armor.head from entity @s armor.head
item replace entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] armor.chest from entity @s armor.chest
item replace entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] armor.legs from entity @s armor.legs
item replace entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] armor.feet from entity @s armor.feet
item replace entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] weapon.mainhand from entity @s weapon.mainhand
item replace entity @e[type=mannequin,tag=ch.speed.dnew,limit=1] weapon.offhand from entity @s weapon.offhand
scoreboard players operation @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.owner = @s ch.pid
scoreboard players operation @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.life = #dur ch.speed.g
scoreboard players add @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.life 20
scoreboard players set @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.v1 0
execute if score @s ch.speed.vmode matches 1 run scoreboard players set @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.v1 12
execute if score @s ch.speed.vmode matches 1 run scoreboard players set @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.life 22
scoreboard players set @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.v2 0
execute if score @s ch.b2 matches 2.. run scoreboard players set @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.v2 1
scoreboard players operation @e[type=mannequin,tag=ch.speed.dnew,limit=1] ch.v3 = @s ch.speed.vmode
tag @e[type=mannequin,tag=ch.speed.dnew] remove ch.speed.dnew
