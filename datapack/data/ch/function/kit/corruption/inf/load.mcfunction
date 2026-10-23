# As an infection marker: loads its settings into scratch (for spreading it on).
scoreboard players operation #cgen ch.tmp = @s ch.v2
scoreboard players operation #crad ch.tmp = @s ch.v3
scoreboard players operation #cdmg ch.tmp = @s ch.v4
scoreboard players operation #cnec ch.tmp = @s ch.v6
execute store success score #cfc ch.tmp if entity @s[tag=ch.corruption.fc]
execute store success score #cfb ch.tmp if entity @s[tag=ch.corruption.fb]
execute store success score #cfa ch.tmp if entity @s[tag=ch.corruption.fa]
scoreboard players set #cfl ch.tmp 0
scoreboard players set #cfs ch.tmp 0
execute if entity @s[tag=ch.corruption.fs] run scoreboard players operation #crad ch.tmp /= #2 ch.g
scoreboard players set #cfuse ch.tmp 60
