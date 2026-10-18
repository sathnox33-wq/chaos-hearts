# Runs once after a player dies. Works out who gets credit and drops their latest heart for them.
scoreboard players set @s ch.deaths 0
execute if score @s ch.trial matches 1.. run return run function ch:trial/player_died
scoreboard players set #credit ch.tmp 0
scoreboard players operation #dt ch.tmp = #now ch.g
scoreboard players operation #dt ch.tmp -= #killer_t ch.g
execute if score #dt ch.tmp matches 0..1 unless score #killer ch.g = @s ch.pid run scoreboard players operation #credit ch.tmp = #killer ch.g
execute if score #credit ch.tmp matches 0 if score @s ch.ctag > #now ch.g run scoreboard players operation #credit ch.tmp = @s ch.opp
scoreboard players set @s ch.ctag 0
execute if score #credit ch.tmp matches 0 run return 0
scoreboard players operation #victim ch.tmp = @s ch.pid
execute as @a if score @s ch.pid = #credit ch.tmp run function ch:mastery/pvp_kill
function ch:heart/drop_latest
