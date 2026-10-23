# A shard pierced something: damage, chill, Frostbite and Shard Sniper; it breaks after its last pierce.
scoreboard players operation #f_dmg ch.tmp = @s ch.v2
execute as @e[tag=ch.target] at @s run function ch:kit/frozen/shard/hit_one
scoreboard players remove @s ch.v3 1
execute if score @s ch.v3 matches ..0 run function ch:api/proj_end with storage ch:tmp p
