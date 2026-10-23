# As the challenger: Hrimvald's damage ($(d) tenths), with the frost overlay.
tag @e[tag=ch.frozen.boss,distance=..120,limit=1] add ch.caster
$function ch:api/hit {d:$(d)}
tag @e[tag=ch.frozen.boss] remove ch.caster
function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:1,stay:6,out:14}
