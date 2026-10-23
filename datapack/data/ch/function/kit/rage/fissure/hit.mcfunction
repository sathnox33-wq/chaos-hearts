# Caught by the fissure: hurt and thrown into the air.
scoreboard players operation @s ch.rage.fh = #fe ch.tmp
$function ch:api/hit {d:$(d)}
function ch:api/push {s:0.15,y:0.95}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"vignette",color:"#E0262B",in:0,stay:3,out:10}
execute as @a[tag=ch.caster,limit=1] run scoreboard players set #fa ch.tmp 4
execute as @a[tag=ch.caster,limit=1] run function ch:kit/rage/fury/add
