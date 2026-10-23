# As a player near the orb: a wind-pull every half second and heavy steps.
execute if score #vt ch.tmp matches 0 run function ch:api/pull {s:0.3}
execute if score #vt ch.tmp matches 5 run function ch:api/pull {s:0.3}
function ch:kit/void/afflict {e:"slowness",sec:1,amp:1}
