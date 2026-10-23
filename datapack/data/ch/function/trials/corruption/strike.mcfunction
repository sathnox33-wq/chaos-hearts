# As a player hit by Nyxara: $(d) tenths of damage credited to the boss, with her rot on their screen.
tag @e[tag=ch.corruption.boss,distance=..120,limit=1,sort=nearest] add ch.caster
$function ch:api/hit {d:$(d)}
tag @e[tag=ch.caster,tag=ch.corruption.boss,distance=..120] remove ch.caster
function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:0,stay:4,out:12}
