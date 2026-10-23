# Nova visuals: a dome of frost, expanding rings, radiating ice beams, a white flash.

particle minecraft:end_rod ~ ~1 ~ 0.3 0.3 0.3 0.4 30
$execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:0.5,s1:$(dia),t:4,life:9,spin:90,dy:0.0}
$execute rotated 0 0 run function ch:api/fx/wave {color:15924223,r:$(r),t:5}
$execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:6273256,s0:1.0,s1:$(dia),t:6,life:24,spin:170,dy:0.0}
$execute rotated 0 0 positioned ~ ~0.7 ~ run function ch:api/fx/sprite {model:"ring",color:10217471,s0:0.5,s1:$(dia),t:7,life:11,spin:-120,dy:0.0}
$function ch:api/fx/ring {p:"minecraft:snowflake",r:$(r)}
function ch:api/fx/orb {color:15924223,s:3.0,t:3,life:6}
execute positioned ~ ~0.8 ~ rotated 0 -8 run function ch:api/fx/beam {color:10217471,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 45 -8 run function ch:api/fx/beam {color:15924223,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 90 -8 run function ch:api/fx/beam {color:10217471,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 135 -8 run function ch:api/fx/beam {color:15924223,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 180 -8 run function ch:api/fx/beam {color:10217471,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 225 -8 run function ch:api/fx/beam {color:15924223,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 270 -8 run function ch:api/fx/beam {color:10217471,w:0.12,len:6.0,t:3,life:7}
execute positioned ~ ~0.8 ~ rotated 315 -8 run function ch:api/fx/beam {color:15924223,w:0.12,len:6.0,t:3,life:7}
particle minecraft:snowflake ~ ~1 ~ 2 0.8 2 0.15 80
particle minecraft:block{block_state:"minecraft:ice"} ~ ~0.5 ~ 2 0.4 2 0.2 40
function ch:api/fx/light {t:6}
function ch:api/fx/shake {s:2,t:8,r:12}
function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:0,stay:3,out:10}
playsound chaoshearts:frozen_nova player @a ~ ~ ~ 1.6 1
playsound minecraft:block.amethyst_block.resonate player @a ~ ~ ~ 1.5 0.6
playsound minecraft:block.glass.break player @a ~ ~ ~ 1.2 0.6
