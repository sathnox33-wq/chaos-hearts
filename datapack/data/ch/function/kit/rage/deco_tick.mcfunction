# A persistent Rage display (banner pieces): counts down its life, fades, then disappears.
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches 3 run function ch:api/fx/fade
execute if score @s ch.life matches ..0 run kill @s
