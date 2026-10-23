# Hit by the dive.
function ch:trials/celestial/hurt {d:80}
execute positioned as @e[tag=ch.caster,limit=1] run function ch:api/push {s:0.8,y:0.6}
