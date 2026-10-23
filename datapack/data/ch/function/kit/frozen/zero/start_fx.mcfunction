# The temperature drops to nothing: a white shockwave, a dome of frost and a howl.
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:snowflake ~ ~2 ~ 4 2 4 0.2 200
particle minecraft:end_rod ~ ~1 ~ 0.5 0.5 0.5 0.4 40
execute rotated 0 0 run function ch:api/fx/wave {color:15924223,r:10.0,t:8}
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:1.0,s1:20.0,t:8,life:14,spin:90,dy:0.0}
function ch:api/fx/pillar {model:"beam",color:15924223,w:1.5,h:26.0,t:4,life:16}
function ch:api/fx/sprite {model:"star",color:15924223,s0:1.0,s1:10.0,t:5,life:9,spin:170,dy:1.0}
function ch:api/fx/screen {o:"frozen",color:"#F2FBFF",in:1,stay:10,out:20}
function ch:api/fx/shake {s:2,t:12,r:16}
function ch:api/fx/light {t:10}
title @s subtitle {text:"❄ ABSOLUTE ZERO ❄",color:"#9BE7FF",bold:true}
title @s title {text:""}
playsound chaoshearts:frozen_blizzard player @a ~ ~ ~ 2 1
playsound minecraft:entity.elder_guardian.curse player @a ~ ~ ~ 0.8 1.6
playsound minecraft:block.powder_snow.break player @a ~ ~ ~ 2 0.4
