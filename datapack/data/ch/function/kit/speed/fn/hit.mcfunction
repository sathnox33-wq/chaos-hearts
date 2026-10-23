# As the target, with the caster tagged ch.caster: deals #d ch.speed.g tenths through ch:api/hit.
execute store result storage ch:kspeed h.d int 1 run scoreboard players get #d ch.speed.g
function ch:api/hit with storage ch:kspeed h
