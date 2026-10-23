# Sorts who stands inside (radius $(r)): allies (not fighting the owner) and enemies.
$tag @a[distance=..$(r),gamemode=!spectator] add ch.celestial.al
execute as @a[tag=ch.celestial.al,tag=!ch.caster] if score @s ch.opp = #ce_o ch.tmp if score @s ch.ctag > #now ch.g run tag @s remove ch.celestial.al
$tag @e[type=#ch:hostile,tag=!ch.noability,distance=..$(r)] add ch.celestial.en
$tag @e[tag=ch.tmob,type=!#ch:ignore,distance=..$(r)] add ch.celestial.en
$tag @a[tag=!ch.celestial.al,gamemode=!spectator,gamemode=!creative,distance=..$(r)] add ch.celestial.en
