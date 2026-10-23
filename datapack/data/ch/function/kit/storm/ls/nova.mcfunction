# Stormcall lands: a bolt onto the caster, a ring of lightning blasting outward.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
execute at @a[tag=ch.caster,limit=1] run function ch:kit/storm/ls/nova_at
