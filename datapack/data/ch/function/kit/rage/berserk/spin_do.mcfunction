# One Ravage spin (#sp ch.tmp = 1..3), as the caster.
scoreboard players set #rd ch.tmp 45
execute if score #sp ch.tmp matches 3 run scoreboard players set #rd ch.tmp 60
execute if score @s ch.b1 matches 2.. run scoreboard players operation #rd ch.tmp *= #12 ch.rage.g
execute if score @s ch.b1 matches 2.. run scoreboard players operation #rd ch.tmp /= #10 ch.g
execute store result storage ch:tmp rage.d int 1 run scoreboard players get #rd ch.tmp
tag @s add ch.caster
execute if score #sp ch.tmp matches ..2 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3.2] run function ch:kit/rage/berserk/spin_in with storage ch:tmp rage
execute if score #sp ch.tmp matches 3 as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.2] run function ch:kit/rage/berserk/spin_out with storage ch:tmp rage
tag @s remove ch.caster
execute rotated ~ 0 run function ch:api/fx/slash {color:14689835,s:3.4,roll:10,t:3}
execute rotated ~120 0 run function ch:api/fx/slash {color:16738847,s:3.4,roll:-10,t:3}
execute rotated ~240 0 run function ch:api/fx/slash {color:14689835,s:3.4,roll:5,t:3}
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:14689835,s0:1.0,s1:6.5,t:4,life:7,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:16738847,r:3.2,t:4}
particle minecraft:sweep_attack ~ ~1 ~ 1.8 0.2 1.8 0 8
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1.2 0.5
playsound chaoshearts:rage_berserk player @a ~ ~ ~ 0.8 1.2
execute if score #sp ch.tmp matches 3 run function ch:kit/rage/berserk/spin_final
execute if score #sp ch.tmp matches ..2 run function ch:api/later {t:10,then:"ch:kit/rage/berserk/spin"}
scoreboard players add #sp ch.tmp 1
execute if score #sp ch.tmp matches ..3 run scoreboard players operation @e[type=marker,tag=ch.lnew,distance=..0.5,limit=1,sort=nearest] ch.v1 = #sp ch.tmp
