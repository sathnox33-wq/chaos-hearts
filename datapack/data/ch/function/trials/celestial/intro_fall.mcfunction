# Intro beat: a shower of light falls onto the constellation ring.
execute rotated 0 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 30 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 60 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 90 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 120 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 150 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 180 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 210 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 240 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 270 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 300 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
execute rotated 330 0 positioned ^ ^ ^16 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16777215,w:0.5,h:24.0,t:3,life:10}
function ch:api/fx/wave {color:16773808,r:16,t:16}
particle minecraft:firework ~ ~1 ~ 12 1 12 0.05 80
playsound minecraft:entity.firework_rocket.twinkle master @a[tag=ch.challenger] ~ ~ ~ 1.5 1
