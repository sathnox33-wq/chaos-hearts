# Null Touch: the struck enemy is shrouded in Darkness (twice as long with Deep Dark).
execute if entity @a[tag=ch.caster,scores={ch.b3=1..},limit=1] run function ch:kit/void/afflict {e:"darkness",sec:6,amp:0}
execute unless entity @a[tag=ch.caster,scores={ch.b3=1..},limit=1] run function ch:kit/void/afflict {e:"darkness",sec:3,amp:0}
particle minecraft:dust{color:[0.039,0.0,0.078],scale:1.8} ~ ~1.2 ~ 0.3 0.45 0.3 0 12
particle minecraft:squid_ink ~ ~1.1 ~ 0.2 0.3 0.2 0.03 5
particle minecraft:reverse_portal ~ ~1.1 ~ 0.2 0.3 0.2 0.05 6
