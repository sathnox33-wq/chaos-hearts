# As the attacker: puts the attacker and the player tagged ch.victim in combat with each other.
execute if score @s ch.trial matches 1.. run return 0
scoreboard players operation #a ch.tmp = @s ch.pid
scoreboard players operation #b ch.tmp = @a[tag=ch.victim,limit=1] ch.pid
scoreboard players operation #until ch.tmp = #combat_sec ch.cfg
scoreboard players operation #until ch.tmp *= #20 ch.g
scoreboard players operation #until ch.tmp += #now ch.g
scoreboard players operation @s ch.opp = #b ch.tmp
scoreboard players operation @s ch.ctag = #until ch.tmp
scoreboard players operation @a[tag=ch.victim,limit=1] ch.opp = #a ch.tmp
scoreboard players operation @a[tag=ch.victim,limit=1] ch.ctag = #until ch.tmp
