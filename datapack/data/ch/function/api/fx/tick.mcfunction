# As an FX display, every tick: starts its animation one tick after it appeared, then counts down its life.
execute if entity @s[tag=ch.fxwait] if score @s ch.t < #now ch.g run function ch:api/fx/start
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches 3 run function ch:api/fx/fade
execute if score @s ch.life matches ..0 run kill @s
