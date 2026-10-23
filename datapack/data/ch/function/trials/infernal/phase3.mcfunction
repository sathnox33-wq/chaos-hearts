# Phase 3: the floor's edge turns to magma and the pillars become columns of fire.
function ch:trials/infernal/callout {t:"The throne room burns! Stay off the magma!"}
execute at @e[type=marker,tag=ch.session,distance=..90,limit=1,sort=nearest] run function ch:trials/infernal/p3_floor
