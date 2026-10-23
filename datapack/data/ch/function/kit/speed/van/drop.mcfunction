# Drops vault slot $(s) as an item at the player's feet.
summon minecraft:item ~ ~0.5 ~ {Item:{id:"minecraft:stone",count:1},Tags:["ch.speed.drop"],PickupDelay:10s}
$item replace entity @e[type=item,tag=ch.speed.drop,limit=1,sort=nearest] contents from entity @e[type=armor_stand,tag=ch.speed.vthis,limit=1] $(s)
tag @e[type=item,tag=ch.speed.drop] remove ch.speed.drop
