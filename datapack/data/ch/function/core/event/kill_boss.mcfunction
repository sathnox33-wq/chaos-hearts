# Advancement reward: this player killed a Wither, Warden, Elder Guardian or Ender Dragon.
advancement revoke @s only ch:event/kill_boss
execute unless score @s ch.active matches 1.. run return 0
execute if score @s ch.trial matches 1.. run return 0
scoreboard players operation #x ch.tmp = #xp_boss ch.cfg
function ch:mastery/award
