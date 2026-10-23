# Swap: the caster and the target trade places through two rifts.
summon marker ~ ~ ~ {Tags:["ch.void.swpa","ch.noability"]}
function ch:kit/void/disp/portal
execute at @e[tag=ch.void.dt,limit=1] run function ch:kit/void/disp/portal
execute at @e[tag=ch.void.dt,limit=1] run tp @s ~ ~ ~
execute at @e[type=marker,tag=ch.void.swpa,limit=1] run tp @e[tag=ch.void.dt,limit=1] ~ ~ ~
kill @e[type=marker,tag=ch.void.swpa]
function ch:api/fx/shake {s:1,t:5,r:4}
function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:0,stay:2,out:8}
