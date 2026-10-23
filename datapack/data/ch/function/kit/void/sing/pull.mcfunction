# Drags everything within the radius toward the hole.
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r),limit=24] run function ch:kit/void/sing/grab
