# Starts a VFX timeline: a marker here, facing the current rotation, that runs $(f) as itself every tick for $(n)
# ticks (frame number in its ch.t). Each tick it first moves $(dy) up and $(fw) forward and turns $(spin) degrees, so
# shapes drawn in local coordinates spin, rise or travel. The marker keeps the tag ch.vnew until the next play call
# or the end of the tick: tag it ch.vfol to make it follow its owner, or merge extra values into its data.
tag @e[type=marker,tag=ch.vnew] remove ch.vnew
$summon marker ~ ~ ~ {Tags:["ch.vfx","ch.vnew","ch.noability"],data:{f:"$(f)",spin:$(spin),dy:$(dy),fw:$(fw)}}
execute as @e[type=marker,tag=ch.vnew,limit=1] run tp @s ~ ~ ~ ~ ~
$scoreboard players set @e[type=marker,tag=ch.vnew,limit=1] ch.life $(n)
scoreboard players set @e[type=marker,tag=ch.vnew,limit=1] ch.t 0
execute if entity @s[type=player] run scoreboard players operation @e[type=marker,tag=ch.vnew,limit=1] ch.owner = @s ch.pid
execute unless entity @s[type=player] run scoreboard players operation @e[type=marker,tag=ch.vnew,limit=1] ch.owner = @s ch.owner
execute unless entity @s[type=player] if entity @a[tag=ch.caster,limit=1] run scoreboard players operation @e[type=marker,tag=ch.vnew,limit=1] ch.owner = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players set #vfx ch.g 1
