# The Starstorm pattern: one at the centre, five around it, a few ticks apart.
scoreboard players set #ce_found ch.tmp 1
execute as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/star/drop
execute positioned ~3 ~ ~0 as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/fx/later {t:3,then:"ch:kit/celestial/star/later"}
execute positioned ~-1 ~ ~3 as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/fx/later {t:6,then:"ch:kit/celestial/star/later"}
execute positioned ~-3 ~ ~-1 as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/fx/later {t:9,then:"ch:kit/celestial/star/later"}
execute positioned ~1 ~ ~-3 as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/fx/later {t:12,then:"ch:kit/celestial/star/later"}
execute positioned ~2 ~ ~2.5 as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/fx/later {t:15,then:"ch:kit/celestial/star/later"}
