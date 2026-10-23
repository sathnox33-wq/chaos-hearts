# The ice groans: fair warning before the shatter.
scoreboard players operation #f_o ch.tmp = @a[tag=ch.caster,limit=1] ch.pid
execute as @e[tag=ch.frozen.sp,distance=..20] if score @s ch.frozen.spo = #f_o ch.tmp at @s run function ch:kit/frozen/zero/sp_crack1
