# Calls a star down onto this spot (as the Celestial or a marker with its owner tagged ch.caster).
# Reads #ce_d damage, #ce_r radius (tenths), #ce_sm small, #ce_co comet, #ce_as Ascension hit, #ce_nv self-nova.
execute store result storage ch:tmp cs.r float 0.1 run scoreboard players get #ce_r ch.tmp
execute store result storage ch:tmp cs.d float 0.2 run scoreboard players get #ce_r ch.tmp
function ch:kit/celestial/star/mark with storage ch:tmp cs
execute rotated ~ 0 positioned ^ ^16 ^-4 facing ^ ^-16 ^4 summon item_display run function ch:kit/celestial/star/init
