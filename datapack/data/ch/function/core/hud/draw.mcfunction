# The HUD, sent as one action bar every 5 ticks. It is all custom-font glyphs positioned with pixel spaces, and its
# total width is kept at zero so the pen starts at the screen centre:
#  - an icon for every Chaos Heart drawn exactly over the extra hearts it adds to the health bar (second row)
#  - the active heart's four ability icons above the hotbar, with lock, cooldown sweep and seconds
#  - the heart's resource meter under them
scoreboard players set @s ch.hud 0
execute if score @s ch.eye matches 1.. run return 0
function ch:gen/count
execute if score #owned ch.tmp matches 0 run return 0
data modify storage ch:tmp hud set value []
scoreboard players set #adv ch.tmp 0
scoreboard players operation #i ch.tmp = @s ch.active
function ch:gen/describe
# Vanilla packs heart rows closer together when there are more than two rows (absorption).
execute store result score #rows ch.tmp run attribute @s minecraft:max_health get
execute store result score #abs ch.tmp run data get entity @s AbsorptionAmount
scoreboard players operation #rows ch.tmp += #abs ch.tmp
scoreboard players add #rows ch.tmp 19
scoreboard players operation #rows ch.tmp /= #20 ch.g
scoreboard players set #rh ch.tmp 12
scoreboard players operation #rh ch.tmp -= #rows ch.tmp
execute if score #rh ch.tmp matches 11.. run scoreboard players set #rh ch.tmp 10
execute if score #rh ch.tmp matches ..7 run scoreboard players set #rh ch.tmp 7
execute store result storage ch:tmp n.r int 1 run scoreboard players get #rh ch.tmp
scoreboard players operation #pulse ch.tmp = #now ch.g
scoreboard players operation #pulse ch.tmp /= #10 ch.g
scoreboard players operation #pulse ch.tmp %= #2 ch.g
scoreboard players set #dx ch.tmp -91
function ch:core/hud/move
scoreboard players set #k ch.tmp 0
function ch:gen/hud_hearts
execute if score @s ch.active matches 1.. run function ch:core/hud/abilities
execute if score @s ch.active matches 1.. if score @s ch.meter matches 1.. run function ch:core/hud/meter
scoreboard players set #dx ch.tmp 0
scoreboard players operation #dx ch.tmp -= #adv ch.tmp
function ch:core/hud/move
title @s actionbar {storage:"ch:tmp",nbt:"hud[]",interpret:true,separator:""}
