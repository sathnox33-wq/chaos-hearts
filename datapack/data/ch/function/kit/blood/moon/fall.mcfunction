# Moonfall (Blood Moon, looking down): picks the impact point (where you look, up to 24 blocks, on the ground).
function ch:api/ray {range:24}
execute as @e[type=marker,tag=ch.rayend,limit=1] at @s run function ch:kit/blood/moon/fall_at
scoreboard players set @s ch.blood.mv 0
playsound minecraft:entity.evoker.prepare_summon player @a ~ ~ ~ 1.4 0.6
playsound chaoshearts:blood_moon player @a ~ ~ ~ 1.4 1.3
return 1
