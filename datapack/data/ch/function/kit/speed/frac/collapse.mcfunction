# Chrono Collapse: everything inside is dragged to the centre and pays for every half second it spent there.
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] at @s run function ch:kit/speed/frac/collapse_one
function ch:api/fx/sprite {model:"orb",color:16777215,s0:0.2,s1:5.0,t:3,life:6,spin:0,dy:0.0}
$function ch:api/fx/wave {color:16113986,r:$(r),t:6}
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:sonic_boom ~ ~1 ~ 1 0.5 1 0 4
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.2 1.4
playsound minecraft:entity.warden.sonic_boom player @a ~ ~ ~ 1 1.6
$function ch:api/fx/shake {s:3,t:12,r:$(r)}
