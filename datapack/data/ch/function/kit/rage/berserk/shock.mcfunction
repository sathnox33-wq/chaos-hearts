# The Berserk shockwave, at the victim (radius 2.5, 3.5 with Cleave).
execute store result storage ch:tmp rage.d int 1 run scoreboard players get #bd ch.tmp
execute if score #cl ch.tmp matches 3.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.victim,tag=!ch.noability,distance=..3.5] run function ch:kit/rage/berserk/shock_hit with storage ch:tmp rage
execute unless score #cl ch.tmp matches 3.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.victim,tag=!ch.noability,distance=..2.5] run function ch:kit/rage/berserk/shock_hit with storage ch:tmp rage
execute if score #bc ch.tmp matches 1 run function ch:kit/rage/berserk/fx1
execute if score #bc ch.tmp matches 2 run function ch:kit/rage/berserk/fx2
execute if score #bc ch.tmp matches 3.. run function ch:kit/rage/berserk/fx3
