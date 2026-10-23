# As an enemy struck by the Supercell.
function ch:kit/storm/fn/zap
function ch:api/stun {t:20}
execute positioned as @a[tag=ch.caster,limit=1] run function ch:api/push {s:1.2,y:0.6}
