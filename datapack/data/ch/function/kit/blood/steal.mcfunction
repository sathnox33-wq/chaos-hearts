# Lifesteal (passive 1) on the melee damage dealt since last tick.
function ch:kit/blood/rate
scoreboard players operation #dk ch.tmp = @s ch.blood.dealt
scoreboard players operation #dk ch.tmp *= #rate ch.tmp
scoreboard players operation #dk ch.tmp /= #100 ch.g
scoreboard players set @s ch.blood.dealt 0
scoreboard players set #bk ch.tmp 0
function ch:kit/blood/drink
