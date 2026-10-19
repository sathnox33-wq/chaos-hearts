# Cooldown sweep (darkens the part of the icon still cooling) and the seconds left in the corner.
$scoreboard players operation #f ch.tmp = @s ch.cd$(s)
scoreboard players operation #f ch.tmp *= #8 ch.g
$scoreboard players operation #m ch.tmp = @s ch.cdm$(s)
execute if score #m ch.tmp matches ..0 run scoreboard players set #m ch.tmp 1
scoreboard players operation #f ch.tmp += #m ch.tmp
scoreboard players remove #f ch.tmp 1
scoreboard players operation #f ch.tmp /= #m ch.tmp
execute if score #f ch.tmp matches 9.. run scoreboard players set #f ch.tmp 8
execute store result storage ch:tmp n.c int 1 run scoreboard players get #f ch.tmp
function ch:core/hud/sweep with storage ch:tmp n
$scoreboard players operation #sec ch.tmp = @s ch.cd$(s)
scoreboard players add #sec ch.tmp 19
scoreboard players operation #sec ch.tmp /= #20 ch.g
execute if score #sec ch.tmp matches 100.. run scoreboard players set #sec ch.tmp 99
execute if score #sec ch.tmp matches 10.. run function ch:core/hud/digits2
execute if score #sec ch.tmp matches ..9 run function ch:core/hud/digits1
scoreboard players set #dx ch.tmp 2
function ch:core/hud/move
