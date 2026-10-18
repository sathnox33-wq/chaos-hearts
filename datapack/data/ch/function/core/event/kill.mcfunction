# Advancement reward: this player killed something.
advancement revoke @s only ch:event/kill
tag @s add ch.caster
function ch:gen/on_kill
tag @s remove ch.caster
