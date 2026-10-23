# The channelled beam's visible light (no damage).
tag @s add ch.caster
scoreboard players set #ce_n ch.tmp 0
scoreboard players set #ce_max ch.tmp 48
scoreboard players set #ce_first ch.tmp 1
scoreboard players set #ce_ex ch.tmp 0
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:kit/celestial/beam/march
tag @e[tag=ch.celestial.bt] remove ch.celestial.bt
execute store result storage ch:tmp cb.len float 0.5 run scoreboard players get #ce_n ch.tmp
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:kit/celestial/beam/ch_layers with storage ch:tmp cb
playsound minecraft:block.beacon.ambient player @a ~ ~ ~ 0.8 2
tag @s remove ch.caster
