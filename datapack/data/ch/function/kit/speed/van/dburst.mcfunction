# Decoy Burst: the fading decoy slows everything near it.
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4] run function ch:api/cc {effect:"minecraft:slowness",sec:3,amp:1}
function ch:api/fx/ring {p:"minecraft:dust{color:[0.16,0.83,0.95],scale:1.2}",r:4}
function ch:api/fx/wave {color:2741234,r:4.0,t:6}
particle minecraft:reverse_portal ~ ~1 ~ 1.5 0.5 1.5 0.05 30
