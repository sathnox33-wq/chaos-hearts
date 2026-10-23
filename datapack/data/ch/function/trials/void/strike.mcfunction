# As a player hit by the Hollow Sovereign: $(d) tenths of damage credited to the boss, and the void floods their eyes.
tag @e[tag=ch.void.boss,distance=..120,limit=1,sort=nearest] add ch.caster
$function ch:api/hit {d:$(d)}
tag @e[tag=ch.caster,tag=ch.void.boss,distance=..120] remove ch.caster
function ch:api/fx/screen {o:"void",color:"#8A3CFF",in:0,stay:4,out:12}
