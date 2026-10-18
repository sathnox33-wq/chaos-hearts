# As the killer of player #victim ch.tmp: PvP kill XP, once per victim every 30 minutes.
execute unless score @s ch.active matches 1.. run return 0
data modify storage ch:tmp k set value {k:0,v:0}
execute store result storage ch:tmp k.k int 1 run scoreboard players get @s ch.pid
execute store result storage ch:tmp k.v int 1 run scoreboard players get #victim ch.tmp
function ch:mastery/pvp_kill2 with storage ch:tmp k
