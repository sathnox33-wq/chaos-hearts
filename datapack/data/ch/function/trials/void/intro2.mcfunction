# Later: the island's eight pillars flare one after another.
playsound minecraft:block.beacon.activate master @a[tag=ch.challenger] ~ ~ ~ 1 0.6
execute rotated 22 0 positioned ^ ^1 ^27 run function ch:api/fx/pillar {model:"beam",color:13864191,w:1.4,h:18.0,t:8,life:30}
execute rotated 112 0 positioned ^ ^1 ^27 run function ch:api/fx/pillar {model:"beam",color:13864191,w:1.4,h:18.0,t:8,life:30}
execute rotated 202 0 positioned ^ ^1 ^27 run function ch:api/fx/pillar {model:"beam",color:13864191,w:1.4,h:18.0,t:8,life:30}
execute rotated 292 0 positioned ^ ^1 ^27 run function ch:api/fx/pillar {model:"beam",color:13864191,w:1.4,h:18.0,t:8,life:30}
execute positioned ~ ~1.1 ~ run function ch:api/fx/wave {color:9059583,r:26.0,t:16}
