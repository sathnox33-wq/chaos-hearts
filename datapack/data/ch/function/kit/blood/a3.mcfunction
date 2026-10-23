# Siphon. Level: tether the enemy you look at (or the nearest within 8) and drink 1.5 a half-second for 4 s; they
# break it by getting 14 blocks away or out of sight. Undeath tethers everyone within 6. Up: Blood Hook, rip the
# target to you (4 damage, a bleed, slowed). Down: Exsanguinate, after a 10-tick pull every enemy bleeding from you
# within 12 bursts for its remaining bleed at once, and you drink half.
execute if score #var ch.tmp matches 1 run return run function ch:kit/blood/siphon/hook
execute if score #var ch.tmp matches 2 run return run function ch:kit/blood/siphon/drain
return run function ch:kit/blood/siphon/tether
