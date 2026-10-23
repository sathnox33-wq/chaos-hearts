# A blow taken in Retaliation stance erupts back at everyone near you.
scoreboard players remove @s ch.rage.bz 1
scoreboard players set @s ch.rage.rcd 8
scoreboard players operation #rd ch.tmp = @s ch.rage.fury
scoreboard players operation #rd ch.tmp /= #4 ch.g
scoreboard players add #rd ch.tmp 40
execute if score @s ch.b1 matches 2.. run scoreboard players operation #rd ch.tmp *= #12 ch.rage.g
execute if score @s ch.b1 matches 2.. run scoreboard players operation #rd ch.tmp /= #10 ch.g
execute store result storage ch:tmp rage.d int 1 run scoreboard players get #rd ch.tmp
tag @s add ch.caster
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.5] run function ch:kit/rage/berserk/shock_hit with storage ch:tmp rage
tag @s remove ch.caster
scoreboard players set #fa ch.tmp 10
function ch:kit/rage/fury/add
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:14689835,r:3.5,t:4}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:3801088,s:3.0,t:2,life:5}
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:16738847,s0:0.5,s1:4.0,t:3,life:6,spin:0,dy:0.0}
execute positioned ~ ~1 ~ rotated ~90 90 run function ch:api/fx/sprite {model:"ring",color:14689835,s0:0.5,s1:4.0,t:3,life:6,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.8 0.6 0.8 0.3 40
particle minecraft:crit ~ ~1 ~ 1 0.6 1 0.6 30
function ch:api/fx/shake {s:2,t:6,r:6}
playsound minecraft:item.mace.smash_ground player @a ~ ~ ~ 1 0.7
playsound chaoshearts:rage_berserk player @a ~ ~ ~ 1 1.4
