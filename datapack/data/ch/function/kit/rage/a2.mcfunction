# War Cry. Level: draw breath (8 ticks, a collapsing ring warns everyone), then a roar that weakens everything near
# you; with 30 Fury it is spent for a roar that also slows, staggers and wounds. Up: Blood Challenge, a war horn to
# the sky that drags enemies in and marks them; their blows feed you double Fury. Down: Blood Oath, tear your own
# heart open for 1.5 hearts: 40 Fury and Strength at once.
execute if score #var ch.tmp matches 2 run return run function ch:kit/rage/cry/oath
execute if score #var ch.tmp matches 1 run return run function ch:kit/rage/cry/challenge
return run function ch:kit/rage/cry/inhale
