# A settings button (codes 50-69): changes the setting, then reopens the page.
execute if score #c ch.tmp matches 50 run function ch:admin/ui/toggle {k:"#starter"}
execute if score #c ch.tmp matches 51 run function ch:admin/ui/toggle {k:"#unique"}
execute if score #c ch.tmp matches 52 run function ch:admin/ui/toggle {k:"#combat_log"}
execute if score #c ch.tmp matches 53 run scoreboard players remove #xp_pct ch.cfg 25
execute if score #c ch.tmp matches 54 run scoreboard players add #xp_pct ch.cfg 25
execute if score #c ch.tmp matches 55 run scoreboard players remove #dmg_pct ch.cfg 10
execute if score #c ch.tmp matches 56 run scoreboard players add #dmg_pct ch.cfg 10
execute if score #c ch.tmp matches 57 run scoreboard players remove #cd_pct ch.cfg 10
execute if score #c ch.tmp matches 58 run scoreboard players add #cd_pct ch.cfg 10
execute if score #c ch.tmp matches 59 run scoreboard players remove #pvp_pct ch.cfg 10
execute if score #c ch.tmp matches 60 run scoreboard players add #pvp_pct ch.cfg 10
execute if score #c ch.tmp matches 61 run scoreboard players remove #collect_sec ch.cfg 60
execute if score #c ch.tmp matches 62 run scoreboard players add #collect_sec ch.cfg 60
execute if score #c ch.tmp matches 69 run function ch:gen/config_reset
execute if score #xp_pct ch.cfg matches ..0 run scoreboard players set #xp_pct ch.cfg 25
execute if score #dmg_pct ch.cfg matches ..0 run scoreboard players set #dmg_pct ch.cfg 10
execute if score #cd_pct ch.cfg matches ..0 run scoreboard players set #cd_pct ch.cfg 10
execute if score #pvp_pct ch.cfg matches ..0 run scoreboard players set #pvp_pct ch.cfg 10
execute if score #collect_sec ch.cfg matches ..59 run scoreboard players set #collect_sec ch.cfg 60
function ch:admin/ui/settings
