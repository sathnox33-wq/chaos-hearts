# Celestial trial intro: the firmament lights up. Stars ignite over the pillars, light pours down, the sigil turns.
tellraw @a[tag=ch.challenger] [{text:"✦ ",color:"#FFF2B0"},{text:"Even a dying star burns brighter than you.",color:"#FFF2B0",italic:true}]
execute positioned ~ ~0.06 ~ run function ch:kit/celestial/fx/sigil {model:"hex",color:16765803,s:32.0,life:200,tag:"ch.celestial.cw"}
execute positioned ~ ~0.08 ~ run function ch:kit/celestial/fx/sigil {model:"rune",color:16773808,s:18.0,life:200,tag:"ch.celestial.rev"}
execute rotated 22.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 67.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 112.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 157.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 202.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 247.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 292.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 337.3 0 positioned ^ ^12 ^22 rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16773808,s0:0.2,s1:2.4,t:40,life:190,spin:170,dy:0.0}
execute rotated 22.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 67.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 112.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 157.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 202.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 247.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 292.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
execute rotated 337.3 0 positioned ^ ^ ^22 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16765803,w:0.7,h:30.0,t:30,life:180}
playsound chaoshearts:celestial_chime master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.7
playsound minecraft:block.beacon.activate master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.6
function ch:api/later {t:60,then:"ch:trials/celestial/intro_fall"}
function ch:api/later {t:130,then:"ch:trials/celestial/intro_fall"}
