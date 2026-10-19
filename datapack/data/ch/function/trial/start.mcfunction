# As a player at an altar: opens the Awakening Trial of their active heart if they qualify.
execute if score @s ch.active matches 0 run return run function ch:core/msg/say {m:"You hold no Chaos Heart.",c:"gray"}
execute if score @s ch.trial matches 1.. run return fail
execute unless score @s ch.lvl matches 100.. run return run function ch:core/msg/say {m:"Reach mastery 100 with this heart to face its trial.",c:"gray"}
execute if score @s ch.awake matches 1 run return run function ch:core/msg/say {m:"This heart is already awakened.",c:"gold"}
execute if score @s ch.ctag > #now ch.g run return run function ch:core/msg/say {m:"You cannot enter a trial while in combat.",c:"red"}
execute unless entity @e[type=marker,tag=ch.altar,distance=..8,limit=1] run return run function ch:core/msg/say {m:"Trials begin at an Awakening Altar.",c:"gray"}
execute unless items entity @s weapon.offhand minecraft:air run return run function ch:core/msg/say {m:"Empty your off hand: the Trial Ward goes there.",c:"yellow"}
scoreboard players operation #i ch.tmp = @s ch.active
function ch:gen/describe
function ch:trial/check_retry with storage ch:tmp h
execute if score #wait ch.tmp matches 1.. run return run function ch:trial/msg_wait
function ch:trial/free_slot
execute if score #free ch.tmp matches -1 run return run function ch:core/msg/say {m:"Every trial arena is in use. Try again soon.",c:"red"}
function ch:trial/begin
