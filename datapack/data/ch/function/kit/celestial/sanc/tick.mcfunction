# A sanctuary, every tick (its owner tagged ch.caster): light pulses, blessings and its mode's work.
scoreboard players remove @s ch.life 1
scoreboard players add @s ch.v4 1
tag @a remove ch.caster
function ch:api/tag_owner
execute unless entity @a[tag=ch.caster,limit=1] run return run kill @s
scoreboard players operation #ce_o ch.tmp = @s ch.owner
execute store result storage ch:tmp cs.r float 0.1 run scoreboard players get @s ch.v1
scoreboard players operation #ce_m ch.tmp = @s ch.v4
scoreboard players operation #ce_m ch.tmp %= #5 ch.celestial.k
execute if score #ce_m ch.tmp matches 0 run function ch:kit/celestial/sanc/pulse with storage ch:tmp cs
scoreboard players operation #ce_m ch.tmp = @s ch.v4
scoreboard players operation #ce_m ch.tmp %= #10 ch.g
execute if score #ce_m ch.tmp matches 0 run function ch:kit/celestial/sanc/bless with storage ch:tmp cs
execute if score @s ch.v2 matches 1 run function ch:kit/celestial/sanc/aegis with storage ch:tmp cs
execute if score @s ch.v2 matches 2 run function ch:kit/celestial/sanc/judge with storage ch:tmp cs
execute if score @s ch.life matches ..0 run function ch:kit/celestial/sanc/close
tag @a remove ch.caster
