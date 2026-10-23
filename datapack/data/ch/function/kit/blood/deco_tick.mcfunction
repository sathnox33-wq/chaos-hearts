# A persistent Blood display: counts down its life (owners refresh it), fades, then disappears.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches 3 if entity @s[type=!marker] run function ch:api/fx/fade
execute if score @s ch.life matches ..0 run kill @s
