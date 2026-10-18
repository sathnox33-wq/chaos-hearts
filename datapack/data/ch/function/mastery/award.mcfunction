# As a player: adds #x ch.tmp mastery XP to the active heart after the server multiplier and the daily soft cap.
execute if score #x ch.tmp matches ..0 run return 0
execute unless score @s ch.active matches 1.. run return 0
scoreboard players operation #day ch.tmp = #now ch.g
scoreboard players set #daylen ch.tmp 1728000
scoreboard players operation #day ch.tmp /= #daylen ch.tmp
execute unless score @s ch.day = #day ch.tmp run scoreboard players set @s ch.xpday 0
scoreboard players operation @s ch.day = #day ch.tmp
scoreboard players operation #x ch.tmp *= #xp_pct ch.cfg
scoreboard players operation #x ch.tmp /= #100 ch.g
execute if score @s ch.xpday >= #daily_cap ch.cfg run scoreboard players operation #x ch.tmp *= #cap_pct ch.cfg
execute if score @s ch.xpday >= #daily_cap ch.cfg run scoreboard players operation #x ch.tmp /= #100 ch.g
execute if score #x ch.tmp matches ..0 run scoreboard players set #x ch.tmp 1
scoreboard players operation @s ch.xpday += #x ch.tmp
function ch:gen/award
