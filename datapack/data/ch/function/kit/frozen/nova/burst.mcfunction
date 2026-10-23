# A Frost Nova of radius $(r) for $(d) (+30% with Cold Snap), freezing what it hits for #f_nf ticks.
scoreboard players set #hits ch.tmp 0
$scoreboard players set #f_nd ch.tmp $(d)
execute if entity @a[tag=ch.caster,scores={ch.active=5,ch.b2=4..},limit=1] run function ch:kit/frozen/nova/cold_snap
$function ch:kit/frozen/nova/fx {r:$(r),dia:$(dia)}
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] at @s run function ch:kit/frozen/nova/hit_one
execute if score #hits ch.tmp matches 4.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"frozen",n:2}
