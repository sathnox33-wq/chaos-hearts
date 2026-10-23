# Down: the tether drains the host each second; it snaps (early burst) if the host gets 14 blocks from you.
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #2 ch.g
execute if score #ct ch.tmp matches 0 if entity @a[tag=ch.caster,limit=1] positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/corruption/inf/tether
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #20 ch.g
execute if score #ct ch.tmp matches 10 run function ch:kit/corruption/inf/drain
execute unless entity @a[tag=ch.caster,distance=..14,limit=1] run function ch:kit/corruption/inf/snap
