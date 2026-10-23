# As a target: deals #ti_d ch.tmp tenths of Titan ability damage (caster tagged ch.caster). Returns 1 when it lands.
execute store result storage ch:tmp ti.d int 1 run scoreboard players get #ti_d ch.tmp
return run function ch:api/hit with storage ch:tmp ti
