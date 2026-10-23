# A delayed pinwheel ember.
scoreboard players operation #i_k ch.tmp = @s ch.v1
scoreboard players operation #i_n ch.tmp = @s ch.v2
scoreboard players operation #i_yaw ch.tmp = @s ch.v3
scoreboard players operation #i_st ch.tmp = @s ch.v4
execute as @a[tag=ch.caster,limit=1] at @s run function ch:kit/infernal/volley/pin_shot
