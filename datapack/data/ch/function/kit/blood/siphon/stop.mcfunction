# Siphon ends: every tether this caster holds lets go.
execute as @e[tag=ch.blood.sipt,distance=..48] if score @s ch.blood.so = #me ch.tmp run function ch:kit/blood/siphon/release
playsound minecraft:entity.generic.drink player @s ~ ~ ~ 0.6 0.5
