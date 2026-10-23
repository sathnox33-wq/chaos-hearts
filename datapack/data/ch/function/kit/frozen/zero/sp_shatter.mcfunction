# SHATTER: every marked enemy still within 14 blocks takes 12 damage (Permafrost adds 40% to the still-frozen).
scoreboard players operation #f_o ch.tmp = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players set #f_dmg ch.tmp 120
execute as @e[tag=ch.frozen.sp,distance=..14] if score @s ch.frozen.spo = #f_o ch.tmp at @s run function ch:kit/frozen/zero/sp_one
execute as @e[tag=ch.frozen.sp,distance=..64] if score @s ch.frozen.spo = #f_o ch.tmp run tag @s remove ch.frozen.sp
function ch:api/fx/shake {s:3,t:12,r:16}
function ch:api/fx/light {t:8}
playsound chaoshearts:frozen_shatter player @a ~ ~ ~ 2 0.7
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1 1.4
