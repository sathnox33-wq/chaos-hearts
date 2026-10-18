# Makes heart index $(i) the active one (0 for none) and restyles the Focus.
function ch:gen/unequip
$scoreboard players set @s ch.active $(i)
function ch:gen/sync_active
function ch:gen/equip
scoreboard players set @s ch.cd1 0
scoreboard players set @s ch.cd2 0
scoreboard players set @s ch.cd3 0
scoreboard players set @s ch.cd4 0
function ch:focus/restyle
