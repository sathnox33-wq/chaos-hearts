# Internal: keeps a timeline marker on its owner's feet (its own turning is kept, unless tagged ch.vfrot: then it
# faces the way its owner faces, level). Fails when the owner is gone.
scoreboard players operation #o ch.tmp = @s ch.owner
execute as @a if score @s ch.pid = #o ch.tmp run tag @s add ch.vfxo
execute unless entity @a[tag=ch.vfxo,limit=1] run return fail
execute if entity @s[tag=!ch.vfrot] positioned as @a[tag=ch.vfxo,limit=1] run tp @s ~ ~ ~
execute if entity @s[tag=ch.vfrot] positioned as @a[tag=ch.vfxo,limit=1] rotated as @a[tag=ch.vfxo,limit=1] run tp @s ~ ~ ~ ~ 0
tag @a remove ch.vfxo
return 1
