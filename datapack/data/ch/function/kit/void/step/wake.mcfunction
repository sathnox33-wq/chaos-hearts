# Shadow Wake: enemies near where you vanished are blinded.
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.5,limit=8] run function ch:api/cc {effect:"minecraft:blindness",sec:2,amp:0}
particle minecraft:squid_ink ~ ~0.5 ~ 2 0.4 2 0.02 40
