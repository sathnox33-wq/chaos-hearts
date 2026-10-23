# While Astrael channels it hangs still; then it moves again.
scoreboard players remove @s ch.v6 1
execute if score @s ch.v6 matches 0 run data merge entity @s {NoAI:0b}
