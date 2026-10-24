# An admin pressed a panel button (/trigger chadmin set <code>). Codes: 1 main, 5 mastery page, 6 settings, 8 help,
# 9 typed commands, 30-31 target tools, 40-45 world tools, 50-69 settings, 1000+pid pick a player,
# 2000+i give, 2100+i take, 2200+i make active, 3000+i awaken, 10000+i*1000+level set mastery (i = heart index).
scoreboard players operation #c ch.tmp = @s chadmin
scoreboard players set @s chadmin 0
execute unless entity @s[tag=ch.admin] run return run tellraw @s {text:"Only Chaos Hearts admins can use this. An op can run /function ch:admin.",color:"red"}
playsound chaoshearts:ui_click player @s ~ ~ ~ 0.5 1
execute if score #c ch.tmp matches 1000..1999 run return run function ch:admin/ui/pick
execute if score #c ch.tmp matches 1 run return run function ch:admin/ui/main
execute if score #c ch.tmp matches 6 run return run function ch:admin/ui/settings
execute if score #c ch.tmp matches 50..69 run return run function ch:admin/ui/setting
execute if score #c ch.tmp matches 8 run return run function ch:admin/help
execute if score #c ch.tmp matches 9 run return run dialog show @s ch:admin
execute if score #c ch.tmp matches 40 run return run function ch:admin/altar/place
execute if score #c ch.tmp matches 41 run return run function ch:admin/altar/remove
execute if score #c ch.tmp matches 42 run return run function ch:eye/on
execute if score #c ch.tmp matches 43 run return run function ch:eye/off
execute if score #c ch.tmp matches 44 run return run function ch:admin/list
execute if score #c ch.tmp matches 45 run return run function ch:admin/ui/return_all
# everything below acts on the picked player
execute unless function ch:admin/ui/tag_target run return run function ch:admin/ui/main
execute if score #c ch.tmp matches 5 run function ch:admin/ui/mastery
execute if score #c ch.tmp matches 30 run function ch:admin/ui/cooldowns
execute if score #c ch.tmp matches 31 run function ch:admin/ui/heal
execute if score #c ch.tmp matches 2001..2010 run function ch:admin/ui/heart_do {f:"ch:admin/ui/give",o:2000}
execute if score #c ch.tmp matches 2101..2110 run function ch:admin/ui/heart_do {f:"ch:admin/ui/take",o:2100}
execute if score #c ch.tmp matches 2201..2210 run function ch:admin/ui/make_active
execute if score #c ch.tmp matches 3001..3010 run function ch:admin/ui/heart_do {f:"ch:admin/ui/awaken",o:3000}
execute if score #c ch.tmp matches 10000..20100 run function ch:admin/ui/mastery_do
execute if score #c ch.tmp matches 3001..20100 run function ch:admin/ui/mastery
execute if score #c ch.tmp matches 30..2210 run function ch:admin/ui/target
tag @a remove ch.adtgt
