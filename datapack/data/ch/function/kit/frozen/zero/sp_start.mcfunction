# Shatterpoint: a freezing wave rolls out 12 blocks; 8 ticks later all inside freeze, 40 ticks after that they shatter.
scoreboard players set @s ch.frozen.zero 80
scoreboard players set @s ch.frozen.zk 0
execute rotated 0 0 run function ch:api/fx/wave {color:15924223,r:12.0,t:8}
execute rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"dome",color:10217471,s0:1.0,s1:24.0,t:8,life:12,spin:90,dy:0.0}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"hex",color:3108776,s0:2.0,s1:24.0,t:8,life:50,spin:170,dy:0.0}
particle minecraft:snowflake ~ ~1 ~ 3 1 3 0.3 120
function ch:api/fx/screen {o:"frozen",color:"#F2FBFF",in:1,stay:6,out:14}
playsound chaoshearts:frozen_blizzard player @a ~ ~ ~ 2 0.6
playsound minecraft:entity.elder_guardian.curse player @a ~ ~ ~ 0.8 1.2
title @s subtitle {text:"❄ SHATTERPOINT ❄",color:"#9BE7FF",bold:true}
title @s title {text:""}
function ch:api/later {t:8,then:"ch:kit/frozen/zero/sp_freeze"}
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
return 1
