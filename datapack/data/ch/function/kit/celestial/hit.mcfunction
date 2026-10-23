# As a target: deals #ce_d ch.tmp tenths of Celestial damage (+25% to undead with Radiance). Returns 1 when it lands.
scoreboard players operation #ce_dx ch.tmp = #ce_d ch.tmp
execute if entity @s[type=#ch:undead] if entity @a[tag=ch.caster,scores={ch.lvl=25..},limit=1] run scoreboard players operation #ce_dx ch.tmp *= #5 ch.celestial.k
execute if entity @s[type=#ch:undead] if entity @a[tag=ch.caster,scores={ch.lvl=25..},limit=1] run scoreboard players operation #ce_dx ch.tmp /= #4 ch.g
execute store result storage ch:tmp ce.d int 1 run scoreboard players get #ce_dx ch.tmp
return run function ch:api/hit with storage ch:tmp ce
