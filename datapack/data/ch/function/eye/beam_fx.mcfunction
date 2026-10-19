# As the player the Eye acts on: a black-violet beam from the nearest Eye down to them.
execute positioned ~ ~1 ~ facing entity @a[scores={ch.eye=1..},sort=nearest,limit=1] eyes run function ch:api/fx/beam {color:7348223,w:0.8,len:30.0,t:4,life:20}
particle minecraft:reverse_portal ~ ~1 ~ 0.5 1 0.5 0.4 120 force
particle minecraft:squid_ink ~ ~1 ~ 0.6 1 0.6 0.1 60 force
function ch:api/fx/shake {s:2,t:16,r:6}
