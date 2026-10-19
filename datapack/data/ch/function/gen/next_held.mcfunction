# Generated: #next ch.tmp = the heart the shuffle hotkey moves to.
scoreboard players operation #next ch.tmp = @s ch.active
scoreboard players set #wrap ch.tmp 0
scoreboard players set #above ch.tmp 0
execute if score @s ch.cnt.corruption matches 1.. if score @s ch.active matches ..9 run scoreboard players set #above ch.tmp 10
execute if score @s ch.cnt.celestial matches 1.. if score @s ch.active matches ..8 run scoreboard players set #above ch.tmp 9
execute if score @s ch.cnt.titan matches 1.. if score @s ch.active matches ..7 run scoreboard players set #above ch.tmp 8
execute if score @s ch.cnt.blood matches 1.. if score @s ch.active matches ..6 run scoreboard players set #above ch.tmp 7
execute if score @s ch.cnt.storm matches 1.. if score @s ch.active matches ..5 run scoreboard players set #above ch.tmp 6
execute if score @s ch.cnt.frozen matches 1.. if score @s ch.active matches ..4 run scoreboard players set #above ch.tmp 5
execute if score @s ch.cnt.void matches 1.. if score @s ch.active matches ..3 run scoreboard players set #above ch.tmp 4
execute if score @s ch.cnt.infernal matches 1.. if score @s ch.active matches ..2 run scoreboard players set #above ch.tmp 3
execute if score @s ch.cnt.speed matches 1.. if score @s ch.active matches ..1 run scoreboard players set #above ch.tmp 2
execute if score @s ch.cnt.rage matches 1.. if score @s ch.active matches ..0 run scoreboard players set #above ch.tmp 1
execute if score @s ch.cnt.corruption matches 1.. run scoreboard players set #wrap ch.tmp 10
execute if score @s ch.cnt.celestial matches 1.. run scoreboard players set #wrap ch.tmp 9
execute if score @s ch.cnt.titan matches 1.. run scoreboard players set #wrap ch.tmp 8
execute if score @s ch.cnt.blood matches 1.. run scoreboard players set #wrap ch.tmp 7
execute if score @s ch.cnt.storm matches 1.. run scoreboard players set #wrap ch.tmp 6
execute if score @s ch.cnt.frozen matches 1.. run scoreboard players set #wrap ch.tmp 5
execute if score @s ch.cnt.void matches 1.. run scoreboard players set #wrap ch.tmp 4
execute if score @s ch.cnt.infernal matches 1.. run scoreboard players set #wrap ch.tmp 3
execute if score @s ch.cnt.speed matches 1.. run scoreboard players set #wrap ch.tmp 2
execute if score @s ch.cnt.rage matches 1.. run scoreboard players set #wrap ch.tmp 1
execute if score #above ch.tmp matches 1.. run return run scoreboard players operation #next ch.tmp = #above ch.tmp
execute if score #wrap ch.tmp matches 1.. run scoreboard players operation #next ch.tmp = #wrap ch.tmp
