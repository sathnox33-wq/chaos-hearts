# Internal: storage ch:tmp fxa holds {model,color,s0,s1,t,life,spin,dy,roll}; optional ax/ay/az and bx/by/bz override the scales.
execute unless data storage ch:tmp fxa.ax run function ch:api/fx/uniform with storage ch:tmp fxa
$scoreboard players set #a ch.tmp $(spin)
execute store result storage ch:tmp fxa.sr float 0.0174533 run scoreboard players get #a ch.tmp
$scoreboard players set #a ch.tmp $(roll)
execute store result storage ch:tmp fxa.rr float 0.0174533 run scoreboard players get #a ch.tmp
function ch:api/fx/summon with storage ch:tmp fxa
