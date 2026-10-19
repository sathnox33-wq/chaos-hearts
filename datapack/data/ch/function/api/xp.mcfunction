# As a player: awards $(n) mastery XP to the active heart (subject to the multiplier and the daily soft cap).
$scoreboard players set #x ch.tmp $(n)
function ch:mastery/award
