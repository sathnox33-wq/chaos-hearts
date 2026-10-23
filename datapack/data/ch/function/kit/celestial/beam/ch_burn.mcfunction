# A Dawnbreaker burn: everything on the beam takes the channel's damage (a third of the lance's).
tag @s add ch.caster
scoreboard players set #hits ch.tmp 0
scoreboard players set #ce_n ch.tmp 0
scoreboard players set #ce_max ch.tmp 48
scoreboard players set #ce_first ch.tmp 1
scoreboard players set #ce_ex ch.tmp 0
scoreboard players operation #ce_d ch.tmp = @s ch.celestial.bmd
scoreboard players operation #ce_d ch.tmp /= #3 ch.celestial.k
scoreboard players add #ce_d ch.tmp 8
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:kit/celestial/beam/march
execute as @e[tag=ch.celestial.bt] at @s run function ch:kit/celestial/beam/hurt
tag @e[tag=ch.celestial.bt] remove ch.celestial.bt
execute if score #hits ch.tmp matches 3.. run function ch:api/feat {h:"celestial",n:2}
tag @s remove ch.caster
