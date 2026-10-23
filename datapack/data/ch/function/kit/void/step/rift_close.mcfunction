# The rift seals unused.
tag @a remove ch.caster
function ch:api/tag_owner
execute as @a[tag=ch.caster,scores={ch.b1=2..},limit=1] run function ch:api/cooldown {slot:1,t:120}
execute as @a[tag=ch.caster,scores={ch.b1=..1},limit=1] run function ch:api/cooldown {slot:1,t:160}
tag @a remove ch.caster
particle minecraft:reverse_portal ~ ~1 ~ 0.2 0.5 0.2 0.2 30
playsound minecraft:block.portal.trigger player @a ~ ~ ~ 0.3 2
kill @s
