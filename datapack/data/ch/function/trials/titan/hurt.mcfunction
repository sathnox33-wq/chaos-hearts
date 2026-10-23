# As the challenger hit by Golgoth (boss tagged ch.caster): $(d) damage, a launch and the Titan overlay.
$function ch:api/hit {d:$(d)}
execute positioned as @e[tag=ch.caster,limit=1] run function ch:api/push {s:0.6,y:0.7}
function ch:api/fx/screen {o:"titan",color:"#C9A45C",in:1,stay:4,out:12}
function ch:api/fx/shake {s:3,t:8,r:1.5}
