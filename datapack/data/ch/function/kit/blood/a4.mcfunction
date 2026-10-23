# Blood Moon. Level: a blood-red moon rises over you for 12 s: Strength I, lifesteal at least 40%, and every enemy
# within 10 bleeds. Up: Crimson Eclipse, the moon stays where you cast it, 14 blocks wide: enemies inside bleed and
# are shrouded in darkness; you drink deeply only inside. Down: Moonfall, a 1.5 s shadow marks where you look, the
# moon crashes there (10 damage near the centre, 6 s bleed), then a 6 s Blood Moon rises over you.
execute if score #var ch.tmp matches 2 run return run function ch:kit/blood/moon/fall
scoreboard players set @s ch.blood.mv 0
execute if score #var ch.tmp matches 1 run scoreboard players set @s ch.blood.mv 1
function ch:kit/blood/moon/rise {t:240}
return 1
