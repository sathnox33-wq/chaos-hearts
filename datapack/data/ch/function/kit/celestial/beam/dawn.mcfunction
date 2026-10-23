# Up: Dawnbreaker. Channel a beam for 2.5 s; it follows your look and burns every half second. You are slowed.
scoreboard players set @s ch.celestial.bm 50
scoreboard players operation @s ch.celestial.bmd = #ce_d ch.tmp
function ch:kit/celestial/beam/gather
playsound chaoshearts:celestial_beam player @a ~ ~ ~ 1.2 0.7
return 1
