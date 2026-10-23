# One half-block step of a beam: tags what it passes, stops at walls or at #ce_max steps.
scoreboard players add #ce_n ch.tmp 1
execute unless block ~ ~ ~ #ch:passable run return run function ch:kit/celestial/beam/end
execute if score #ce_ex ch.tmp matches 0 positioned ~ ~-0.9 ~ run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.celestial.bt,distance=..1.3] add ch.celestial.bnew
execute if score #ce_ex ch.tmp matches 1 positioned ~ ~-0.9 ~ run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.celestial.bt,distance=..1.9] add ch.celestial.bnew
execute if score #ce_first ch.tmp matches 0 if entity @e[tag=ch.celestial.bnew,limit=1] run function ch:kit/celestial/beam/first
tag @e[tag=ch.celestial.bnew] add ch.celestial.bt
tag @e[tag=ch.celestial.bnew] remove ch.celestial.bnew
scoreboard players operation #ce_m ch.tmp = #ce_n ch.tmp
scoreboard players operation #ce_m ch.tmp %= #3 ch.celestial.k
execute if score #ce_m ch.tmp matches 0 run particle minecraft:end_rod ~ ~ ~ 0.08 0.08 0.08 0.02 1
execute if score #ce_m ch.tmp matches 1 run particle minecraft:dust{color:[1.0,0.827,0.42],scale:1.2} ~ ~ ~ 0.1 0.1 0.1 0 1
execute if score #ce_n ch.tmp >= #ce_max ch.tmp run return run function ch:kit/celestial/beam/end
execute positioned ^ ^ ^0.5 run function ch:kit/celestial/beam/march
