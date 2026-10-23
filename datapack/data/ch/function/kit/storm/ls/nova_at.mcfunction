# At the caster: the Stormcall nova.
function ch:kit/storm/fn/bolt
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16777215,s0:0.5,s1:10.0,t:4,life:7,spin:170,dy:0.0}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:5220607,s0:0.5,s1:12.0,t:6,life:9,spin:-170,dy:0.0}
execute rotated 0 0 positioned ^ ^ ^3.5 run function ch:api/fx/pillar {model:"beam",color:15267583,w:0.3,h:10.0,t:1,life:4}
execute rotated 90 0 positioned ^ ^ ^3.5 run function ch:api/fx/pillar {model:"beam",color:15267583,w:0.3,h:10.0,t:1,life:4}
execute rotated 180 0 positioned ^ ^ ^3.5 run function ch:api/fx/pillar {model:"beam",color:15267583,w:0.3,h:10.0,t:1,life:4}
execute rotated 270 0 positioned ^ ^ ^3.5 run function ch:api/fx/pillar {model:"beam",color:15267583,w:0.3,h:10.0,t:1,life:4}
scoreboard players set #d ch.storm.g 60
execute if entity @a[tag=ch.caster,scores={ch.b1=1..},limit=1] run scoreboard players set #d ch.storm.g 72
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.8] at @s run function ch:kit/storm/ls/nova_one
effect give @a[tag=ch.caster,limit=1] minecraft:speed 3 0 true
execute as @a[tag=ch.caster,limit=1] run function ch:api/fx/screen {o:"storm",color:"#E8F6FF",in:0,stay:3,out:10}
function ch:api/fx/shake {s:3,t:10,r:10}
