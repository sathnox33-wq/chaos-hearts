# Runs function $(then) after $(t) ticks, as a marker left at the current position. When it runs, the player who
# owned it (the caster, or the owner of the entity that called this) is tagged ch.caster. The new marker carries
# the tag ch.lnew until the end of the tick, so callers can give it extra data, tags or scores.
$summon marker ~ ~ ~ {Tags:["ch.later","ch.lnew","ch.lnew2"],data:{then:"$(then)"}}
$scoreboard players set @e[type=marker,tag=ch.lnew2,limit=1] ch.t $(t)
scoreboard players operation @e[type=marker,tag=ch.lnew2,limit=1] ch.t += #now ch.g
execute if entity @s[type=player] run scoreboard players operation @e[type=marker,tag=ch.lnew2,limit=1] ch.owner = @s ch.pid
execute unless entity @s[type=player] if entity @a[tag=ch.caster,limit=1] run scoreboard players operation @e[type=marker,tag=ch.lnew2,limit=1] ch.owner = @a[tag=ch.caster,limit=1] ch.pid
execute unless entity @s[type=player] unless entity @a[tag=ch.caster,limit=1] run scoreboard players operation @e[type=marker,tag=ch.lnew2,limit=1] ch.owner = @s ch.owner
tag @e[type=marker,tag=ch.lnew2] remove ch.lnew2
