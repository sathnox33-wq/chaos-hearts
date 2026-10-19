scoreboard players operation #o ch.tmp = @s ch.pid
tag @s add ch.eyeself
execute anchored eyes positioned ^ ^0.4 ^ as @e[type=item_display,tag=ch.eyeball,distance=..12] if score @s ch.owner = #o ch.tmp run tp @s ~ ~ ~ ~ ~
execute anchored eyes positioned ^ ^0.4 ^ as @e[type=item_display,tag=ch.eyeshroud,distance=..12] if score @s ch.owner = #o ch.tmp run tp @s ~ ~ ~ ~ ~
execute anchored eyes positioned ^ ^0.4 ^ as @e[type=item_display,tag=ch.eyetendril,distance=..12] if score @s ch.owner = #o ch.tmp at @s run tp @s ^ ^ ^ ~1.5 ~
execute anchored eyes positioned ^ ^0.4 ^ as @e[type=item_display,tag=ch.eyetendril,distance=..12] if score @s ch.owner = #o ch.tmp run tp @s ~ ~ ~
execute anchored eyes positioned ^ ^0.4 ^ as @e[type=item_display,tag=ch.eyepupil,distance=..12] if score @s ch.owner = #o ch.tmp run function ch:eye/pupil
execute if score #t20 ch.g matches 0 run function ch:eye/pulse
execute if score #t20 ch.g matches 10 run function ch:eye/pulse
particle minecraft:dust{color:[0.02,0.0,0.04],scale:4.0} ~ ~1.6 ~ 1.6 1.6 1.6 0 6
particle minecraft:squid_ink ~ ~1.6 ~ 1.4 1.4 1.4 0.01 2
particle minecraft:large_smoke ~ ~0.4 ~ 1.2 0.4 1.2 0.01 2
execute if score #t20 ch.g matches 5 run particle minecraft:sculk_soul ~ ~1.6 ~ 2 2 2 0.02 4
execute if entity @s[gamemode=!creative] run gamemode creative @s
effect give @s minecraft:invisibility infinite 0 true
tag @s remove ch.eyeself
