# One ray of a Prism Nova.
scoreboard players set #ce_n ch.tmp 0
scoreboard players set #ce_max ch.tmp 24
function ch:kit/celestial/beam/march
execute store result storage ch:tmp cb.len float 0.5 run scoreboard players get #ce_n ch.tmp
function ch:kit/celestial/beam/draw with storage ch:tmp cb
