# The star strikes: a flash of light, rings of gold, sparks, and everything in its radius is hit.
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players operation #ce_d ch.tmp = @s ch.v1
scoreboard players operation #ce_r ch.tmp = @s ch.v2
scoreboard players operation #ce_sm ch.tmp = @s ch.v3
scoreboard players operation #ce_co ch.tmp = @s ch.v4
scoreboard players operation #ce_as ch.tmp = @s ch.v5
scoreboard players operation #ce_nv ch.tmp = @s ch.v6
execute store result storage ch:tmp cs.r float 0.1 run scoreboard players get #ce_r ch.tmp
execute store result storage ch:tmp cs.d float 0.25 run scoreboard players get #ce_r ch.tmp
function ch:kit/celestial/star/boom with storage ch:tmp cs
execute if score #ce_co ch.tmp matches 1 run function ch:kit/celestial/star/comet_fx
execute if score #ce_sm ch.tmp matches 0 run function ch:kit/celestial/star/big_fx
function ch:kit/celestial/star/hits with storage ch:tmp cs
tag @a remove ch.caster
kill @s
