# As an enemy under the Downburst.
scoreboard players add #pushed ch.storm.g 1
function ch:kit/storm/fn/zap
function ch:api/stun {t:15}
execute if entity @s[type=!player,tag=!ch.boss] run data merge entity @s {Motion:[0.0,-1.6,0.0]}
execute if entity @s[type=player] unless predicate ch:on_ground positioned ~ ~2.3 ~ summon minecraft:wind_charge run data merge entity @s {Motion:[0.0,-1.5,0.0]}
particle minecraft:cloud ~ ~0.2 ~ 0.4 0.05 0.4 0.1 8
