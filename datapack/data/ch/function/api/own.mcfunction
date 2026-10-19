# As a summoned entity: records the caster (tagged ch.caster) as its owner.
scoreboard players operation @s ch.owner = @a[tag=ch.caster,limit=1] ch.pid
