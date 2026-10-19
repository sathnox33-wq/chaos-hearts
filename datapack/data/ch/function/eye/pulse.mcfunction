# The shroud breathes and the tendrils writhe; players near the Eye sink into darkness and hear its heartbeat.
execute as @e[type=item_display,tag=ch.eyeshroud,distance=..12] if score @s ch.owner = #o ch.tmp run function ch:eye/breathe
execute as @e[type=item_display,tag=ch.eyetendril,distance=..12] if score @s ch.owner = #o ch.tmp run function ch:eye/writhe
effect give @a[tag=!ch.eyeself,distance=..14] minecraft:darkness 3 0 true
playsound chaoshearts:eye_ambient master @a[distance=..32] ~ ~ ~ 0.7 0.9
