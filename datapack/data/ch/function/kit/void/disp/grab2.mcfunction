# Delivers the grabbed target here, facing the caster.
function ch:kit/void/disp/portal
tp @e[tag=ch.void.dt,limit=1] ~ ~ ~ facing entity @s
execute as @e[tag=ch.void.dt,limit=1] run function ch:api/stun {t:20}
scoreboard players set #vd ch.tmp 40
execute as @e[tag=ch.void.dt,limit=1] run function ch:kit/void/hurt
playsound minecraft:entity.enderman.scream player @a ~ ~ ~ 0.6 1.4
function ch:api/fx/shake {s:2,t:5,r:5}
