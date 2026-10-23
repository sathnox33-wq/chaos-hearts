# Blood Hook (Siphon, looking up): a barbed lash of blood up to 16 blocks rips the target to you.
function ch:api/ray {range:16}
execute unless entity @e[tag=ch.target,type=!#ch:ignore,tag=!ch.noability,limit=1] run return run function ch:kit/blood/siphon/none
execute as @e[tag=ch.target,type=!#ch:ignore,tag=!ch.noability,limit=1] at @s run function ch:kit/blood/siphon/hooked
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:api/fx/beam {color:10357535,w:0.18,len:6.0,t:2,life:6}
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:api/fx/beam {color:16723263,w:0.08,len:10.0,t:3,life:7}
playsound minecraft:entity.fishing_bobber.retrieve player @a ~ ~ ~ 1.2 0.5
playsound minecraft:block.chain.break player @a ~ ~ ~ 1 0.6
playsound chaoshearts:blood_siphon player @a ~ ~ ~ 0.8 1.4
return 1
