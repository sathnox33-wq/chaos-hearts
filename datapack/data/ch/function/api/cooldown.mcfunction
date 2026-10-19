# As the caster: puts ability $(slot) on cooldown for $(t) ticks after the server setting and the honed bonus.
$scoreboard players set #c ch.tmp $(t)
scoreboard players operation #c ch.tmp *= #cd_pct ch.cfg
scoreboard players operation #c ch.tmp /= #100 ch.g
execute if score @s ch.lvl matches 60.. run scoreboard players operation #c ch.tmp *= #85 ch.g
execute if score @s ch.lvl matches 60.. run scoreboard players operation #c ch.tmp /= #100 ch.g
execute if score #c ch.tmp matches ..0 run scoreboard players set #c ch.tmp 1
$scoreboard players operation @s ch.cd$(slot) = #c ch.tmp
$scoreboard players operation @s ch.cdm$(slot) = #c ch.tmp
