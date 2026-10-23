# As a later marker: loads the pending Celestial move back into #ce_ values.
scoreboard players operation #ce_d ch.tmp = @s ch.v1
scoreboard players operation #ce_r ch.tmp = @s ch.v2
scoreboard players operation #ce_sm ch.tmp = @s ch.v3
scoreboard players operation #ce_co ch.tmp = @s ch.v4
scoreboard players operation #ce_as ch.tmp = @s ch.v5
scoreboard players operation #ce_nv ch.tmp = @s ch.v6
scoreboard players operation #ce_pid ch.tmp = @a[tag=ch.caster,limit=1] ch.pid
