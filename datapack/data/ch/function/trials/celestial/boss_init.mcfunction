# Astrael's body, gear, timers and decorations; then the trial framework adopts it as the boss.
attribute @s minecraft:max_health base set 360
attribute @s minecraft:attack_damage base set 9
attribute @s minecraft:scale base set 2.8
attribute @s minecraft:knockback_resistance base set 1
attribute @s minecraft:follow_range base set 64
item replace entity @s weapon.mainhand with minecraft:golden_sword
item replace entity @s armor.head with minecraft:golden_helmet
data merge entity @s {Health:360f,drop_chances:{mainhand:0f,head:0f}}
tag @s add ch.celestial.boss
scoreboard players set @s ch.t 0
scoreboard players set @s ch.phase 1
scoreboard players set @s ch.v1 70
scoreboard players set @s ch.v2 150
scoreboard players set @s ch.v3 120
scoreboard players set @s ch.v4 0
scoreboard players set @s ch.v6 0
scoreboard players set @s ch.celestial.tb1 200
scoreboard players set @s ch.celestial.tb2 260
scoreboard players set @s ch.celestial.tb3 0
function ch:api/trial/boss {name:"Astrael, the Fallen Star",color:"yellow"}
execute summon item_display run function ch:trials/celestial/deco_halo
execute rotated 0 0 summon item_display run function ch:trials/celestial/deco_star
execute rotated 180 0 summon item_display run function ch:trials/celestial/deco_star
execute summon item_display run function ch:trials/celestial/deco_wing {n:1}
execute summon item_display run function ch:trials/celestial/deco_wing {n:2}
execute summon item_display run function ch:trials/celestial/deco_wing {n:3}
execute summon item_display run function ch:trials/celestial/deco_wing {n:4}
function ch:trials/celestial/entrance
