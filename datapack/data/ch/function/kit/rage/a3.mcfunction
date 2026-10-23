# Berserk Chain. Level: your next 3 melee hits (4 awakened) deal bonus damage and escalating shockwaves; the last one
# shatters the ground and stuns. Up: Retaliation, a 5 s stance: up to 4 blows you take erupt back at everyone near
# you. Down: Ravage, three spinning cleaves that drag enemies in, then hurl them away.
execute if score #var ch.tmp matches 2 run return run function ch:kit/rage/berserk/ravage
execute if score #var ch.tmp matches 1 run return run function ch:kit/rage/berserk/stance
return run function ch:kit/rage/berserk/chain
