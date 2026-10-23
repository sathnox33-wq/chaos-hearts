# The windup ends (as its marker, the Titan tagged ch.caster): the boulder is thrown.
execute unless entity @a[tag=ch.caster,scores={ch.active=8},limit=1] run return 0
data modify storage ch:tmp trk.b set from entity @s data.b
scoreboard players operation #ti_x ch.tmp = @s ch.v4
execute as @a[tag=ch.caster,limit=1] at @s run function ch:kit/titan/rock/throw2
