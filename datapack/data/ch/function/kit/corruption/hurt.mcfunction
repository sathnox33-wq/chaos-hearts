# As a target, caster tagged: Corruption ability damage of #cd tenths; Necrosis (#cnec 1) +15% on poisoned targets.
# A landed hit feeds the caster's Contagion meter.
scoreboard players operation #cdx ch.tmp = #cd ch.tmp
execute if score #cnec ch.tmp matches 1 if entity @s[nbt={active_effects:[{id:"minecraft:poison"}]}] run function ch:kit/corruption/necro
execute store result storage ch:corruption h.d int 1 run scoreboard players get #cdx ch.tmp
execute store success score #cl ch.tmp run function ch:api/hit with storage ch:corruption h
execute if score #cl ch.tmp matches 1 run scoreboard players add @a[tag=ch.caster,limit=1] ch.corruption.m 3
execute if score #cl ch.tmp matches 1 run scoreboard players set @a[tag=ch.caster,limit=1] ch.corruption.mt 100
