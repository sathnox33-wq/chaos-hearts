# Everyone else within the burst radius.
$execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,tag=!ch.corruption.hcur,distance=..$(r),limit=16] run function ch:kit/corruption/inf/splash
