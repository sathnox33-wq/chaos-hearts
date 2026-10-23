# Tags this player's armour vault (owner = #pid ch.speed.g) ch.speed.vthis.
tag @e[type=armor_stand,tag=ch.speed.vthis] remove ch.speed.vthis
execute as @e[type=armor_stand,tag=ch.speed.vault] if score @s ch.owner = #pid ch.speed.g run tag @s add ch.speed.vthis
