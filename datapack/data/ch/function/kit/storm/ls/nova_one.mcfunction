# As an enemy caught in the Stormcall nova.
function ch:kit/storm/fn/zap
execute positioned as @a[tag=ch.caster,limit=1] run function ch:api/push {s:1.0,y:0.5}
