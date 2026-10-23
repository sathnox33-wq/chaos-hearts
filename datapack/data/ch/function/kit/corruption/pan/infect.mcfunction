# As an enemy in the outbreak: a thread of plague reaches it and plants an infection.
scoreboard players add #cn ch.tmp 1
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/corruption/inf/tether
function ch:kit/corruption/inf/plant
