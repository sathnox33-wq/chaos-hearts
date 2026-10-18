# Action bar with the active heart's cooldowns, shown while the Focus is in hand.
scoreboard players set @s ch.hud 0
execute unless items entity @s weapon.* carrot_on_a_stick[custom_data~{ch:{focus:1}}] run return 0
execute if score @s ch.active matches 0 run return run title @s actionbar {text:"You have no heart. Win one in PvP.",color:"gray"}
scoreboard players operation #i ch.tmp = @s ch.active
function ch:gen/describe
data modify storage ch:tmp hud set value []
function ch:core/player/hud_head with storage ch:tmp h
function ch:core/player/hud_slot {s:1,k:"R"}
function ch:core/player/hud_slot {s:2,k:"⇧R"}
function ch:core/player/hud_slot {s:3,k:"F"}
function ch:core/player/hud_slot {s:4,k:"⇧F"}
function ch:gen/hud
title @s actionbar {storage:"ch:tmp",nbt:"hud[]",interpret:true,separator:""}
