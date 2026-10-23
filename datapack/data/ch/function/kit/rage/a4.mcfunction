# Rampage. Level: become fury itself for 10 s: Speed II, Strength II, Resistance, 15% melee lifesteal; kills extend
# it. Up: Wrathfall, rocket skyward and crash down as a meteor (marked on the ground), then Rampage for 7 s. Down:
# Blood for Blood, a Rampage with no Resistance: every blow you take is lashed back at the attacker, pain feeds
# double Fury and lifesteal rises to 25%.
execute if score #var ch.tmp matches 1 run return run function ch:kit/rage/rampage/up
scoreboard players set @s ch.rage.rv 0
execute if score #var ch.tmp matches 2 run scoreboard players set @s ch.rage.rv 2
function ch:kit/rage/rampage/begin {t:200}
function ch:kit/rage/rampage/entrance
scoreboard players set #fa ch.tmp 50
function ch:kit/rage/fury/add
return 1
