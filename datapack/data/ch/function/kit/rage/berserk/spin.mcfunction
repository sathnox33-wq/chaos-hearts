# The next Ravage spin, from its marker.
scoreboard players operation #sp ch.tmp = @s ch.v1
execute as @a[tag=ch.caster,limit=1] at @s run function ch:kit/rage/berserk/spin_do
