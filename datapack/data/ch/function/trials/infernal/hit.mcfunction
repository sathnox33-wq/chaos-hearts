# As the challenger: Ignaroth's damage ($(d) tenths), with the burning overlay.
tag @e[tag=ch.infernal.boss,distance=..120,limit=1] add ch.caster
$function ch:api/hit {d:$(d)}
tag @e[tag=ch.infernal.boss] remove ch.caster
function ch:api/fx/screen {o:"infernal",color:"#FF7A1A",in:1,stay:5,out:12}
execute if block ~ ~ ~ #minecraft:air run setblock ~ ~ ~ minecraft:fire
execute if block ~ ~ ~ minecraft:fire run function ch:api/later {t:3,then:"ch:kit/infernal/unfire"}
