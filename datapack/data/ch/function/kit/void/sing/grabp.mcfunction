# As a player in the pull: a wind-pull every 15 ticks, and the gravity weighs on every step.
execute if score #vt10 ch.tmp matches 0 run function ch:api/pull {s:0.4}
function ch:kit/void/afflict {e:"slowness",sec:1,amp:1}
execute if score #vt10 ch.tmp matches 5 run particle minecraft:portal ~ ~1 ~ 0.3 0.5 0.3 0.5 10
