# Titan trial intro: the quarry wakes. Dust columns rise at the broken pillars, a gold sigil spreads, the ground heaves.
tellraw @a[tag=ch.challenger] [{text:"⛰ ",color:"#C9A45C"},{text:"You cannot outlast a mountain. You can only break it.",color:"#C9A45C",italic:true}]
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:13214812,s0:2.0,s1:26.0,t:60,life:190,spin:170,dy:0.0}
execute positioned ~ ~0.04 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:1.0,s1:20.0,t:80,life:190,spin:0,dy:0.0}
execute rotated 22.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 67.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 112.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 157.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 202.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 247.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 292.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
execute rotated 337.9 0 positioned ^ ^ ^21 rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:8025194,w:2.4,h:16.0,t:30,life:180}
playsound chaoshearts:titan_quake master @a[tag=ch.challenger] ~ ~ ~ 1.5 0.6
playsound minecraft:entity.ravager.roar master @a[tag=ch.challenger] ~ ~ ~ 1 0.4
function ch:api/later {t:60,then:"ch:trials/titan/intro_heave"}
function ch:api/later {t:130,then:"ch:trials/titan/intro_heave"}
