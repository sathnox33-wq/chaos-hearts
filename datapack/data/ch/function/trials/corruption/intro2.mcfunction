# Later: the garden breathes out - a rot shockwave and spore columns.
playsound minecraft:entity.warden.heartbeat master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.5
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:8114490,r:26.0,t:16}
execute rotated 31 0 positioned ^ ^1 ^20 run function ch:api/fx/pillar {model:"cloud",color:8114490,w:2.0,h:10.0,t:16,life:30}
execute rotated 151 0 positioned ^ ^1 ^20 run function ch:api/fx/pillar {model:"cloud",color:4004434,w:2.0,h:10.0,t:16,life:30}
execute rotated 271 0 positioned ^ ^1 ^20 run function ch:api/fx/pillar {model:"cloud",color:8114490,w:2.0,h:10.0,t:16,life:30}
