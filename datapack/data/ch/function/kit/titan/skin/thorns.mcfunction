# Spiked Stone: the last attacker takes 2 damage from the spikes (at most once every half second).
scoreboard players set @s ch.titan.thcd 10
tag @s add ch.caster
scoreboard players set #ti_d ch.tmp 20
execute on attacker unless entity @s[tag=ch.caster] at @s run function ch:kit/titan/skin/thorn_hit
tag @s remove ch.caster
