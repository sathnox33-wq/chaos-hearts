# Runs once when a known player comes back online.
scoreboard players set @s ch.leave 0
scoreboard players set @s ch.use 0
function ch:core/player/record_name
# Logging out in combat counts as losing the fight, unless the opponent left first.
execute if score #combat_log ch.cfg matches 1 if score @s ch.ctag > @s ch.seen run function ch:heart/combat_log
scoreboard players set @s ch.ctag 0
function ch:heart/pending/apply
function ch:trial/rejoin
function ch:eye/rejoin
function ch:gen/sync_active
function ch:focus/ensure
