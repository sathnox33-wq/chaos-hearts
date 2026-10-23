# Up: the crown follows its caster, hovering 3.5 blocks over their head (the displays come along).
execute at @a[tag=ch.caster,limit=1] run tp @s ~ ~3.5 ~
execute if score #t20 ch.g matches 0 run effect give @a[tag=ch.caster,limit=1] minecraft:resistance 2 0 true
execute as @e[type=item_display,tag=ch.void.sd,distance=..64] if score @s ch.void.sid = #sid ch.tmp run tp @s @e[type=marker,tag=ch.void.scur,limit=1]
