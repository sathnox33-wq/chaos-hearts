# As an entity with ch.owner: tags its owning player ch.caster. Remove the tag when done (tag @a remove ch.caster).
scoreboard players operation #o ch.tmp = @s ch.owner
execute if score #o ch.tmp matches 1.. as @a if score @s ch.pid = #o ch.tmp run tag @s add ch.caster
