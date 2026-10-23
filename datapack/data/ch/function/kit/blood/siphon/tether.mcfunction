# Siphon (level): picks the tether targets.
scoreboard players operation #me ch.tmp = @s ch.pid
execute if score @s ch.b1 matches 5.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6] run function ch:kit/blood/siphon/bind
execute unless score @s ch.b1 matches 5.. run function ch:api/ray {range:12}
execute unless score @s ch.b1 matches 5.. as @e[tag=ch.target,type=!#ch:ignore,tag=!ch.noability,limit=1] run function ch:kit/blood/siphon/bind
execute unless score @s ch.b1 matches 5.. unless entity @e[tag=ch.blood.sipnew,limit=1] as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..8,sort=nearest,limit=1] run function ch:kit/blood/siphon/bind
tag @e[tag=ch.target] remove ch.target
execute unless entity @e[tag=ch.blood.sipnew,limit=1] run return run function ch:kit/blood/siphon/none
tag @e[tag=ch.blood.sipnew] remove ch.blood.sipnew
scoreboard players set @s ch.blood.sip 80
execute if score @s ch.b1 matches 2.. run scoreboard players set @s ch.blood.sip 112
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:10357535,s0:0.5,s1:2.5,t:4,life:10,spin:170,dy:0.0}
playsound chaoshearts:blood_siphon player @a ~ ~ ~ 1 1
playsound minecraft:entity.zombie_villager.cure player @a ~ ~ ~ 0.4 1.8
return 1
