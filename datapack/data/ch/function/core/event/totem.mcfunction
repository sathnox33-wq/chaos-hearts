# Advancement reward: a death-protection item was used. In a trial this is the Trial Ward: the run fails.
advancement revoke @s only ch:event/totem
execute if score @s ch.trial matches 1.. run function ch:trial/ward_used
