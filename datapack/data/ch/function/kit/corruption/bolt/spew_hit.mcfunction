# As an enemy in the spew.
function ch:kit/corruption/hurt
function ch:kit/corruption/poison {sec:4,amp:1}
execute if score #cpest ch.tmp matches 1 run function ch:kit/corruption/afflict {e:"wither",sec:4,amp:1}
execute at @a[tag=ch.caster,limit=1] run function ch:api/push {s:0.8,y:0.3}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:0,stay:6,out:14}
