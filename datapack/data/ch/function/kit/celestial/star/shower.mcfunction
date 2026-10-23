# Meteor Shower: two smaller stars follow the first onto the same area.
scoreboard players operation #ce_d ch.tmp /= #2 ch.g
scoreboard players set #ce_r ch.tmp 18
scoreboard players set #ce_sm ch.tmp 1
scoreboard players set #ce_co ch.tmp 0
execute if score #rayhit ch.tmp matches 0 at @e[type=marker,tag=ch.rayend,limit=1] positioned ~2.5 ~ ~1.5 run function ch:kit/celestial/fx/later {t:4,then:"ch:kit/celestial/star/later"}
execute if score #rayhit ch.tmp matches 0 at @e[type=marker,tag=ch.rayend,limit=1] positioned ~-2 ~ ~-2.5 run function ch:kit/celestial/fx/later {t:8,then:"ch:kit/celestial/star/later"}
execute if score #rayhit ch.tmp matches 1 at @e[type=marker,tag=ch.rayend,limit=1] positioned ~2.5 ~ ~1.5 run function ch:kit/celestial/fx/later {t:4,then:"ch:kit/celestial/star/later"}
execute if score #rayhit ch.tmp matches 1 at @e[type=marker,tag=ch.rayend,limit=1] positioned ~-2 ~ ~-2.5 run function ch:kit/celestial/fx/later {t:8,then:"ch:kit/celestial/star/later"}
