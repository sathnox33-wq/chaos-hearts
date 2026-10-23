# A delayed volley shot, as its marker with the caster tagged.
scoreboard players operation #i_k ch.tmp = @s ch.v1
scoreboard players operation #i_n ch.tmp = @s ch.v2
execute as @a[tag=ch.caster,limit=1] at @s run function ch:kit/infernal/volley/fan_shot
