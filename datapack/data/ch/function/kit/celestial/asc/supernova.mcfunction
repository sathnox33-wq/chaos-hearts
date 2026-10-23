# Supernova: a blinding explosion of starlight, 10 damage, blindness and knockback within 6 blocks.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
execute positioned as @a[tag=ch.caster,limit=1] positioned ~ ~1 ~ run function ch:kit/celestial/asc/supernova2
