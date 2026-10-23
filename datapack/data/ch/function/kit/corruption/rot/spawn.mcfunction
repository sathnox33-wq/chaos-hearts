# Summons a rot field here, owned by the caster, with a snapshot of the Rotmother branch.
summon marker ~ ~ ~ {Tags:["ch.corruption.rot","ch.corruption.rnew","ch.noability"]}
execute as @e[type=marker,tag=ch.corruption.rnew,limit=1] at @s run function ch:kit/corruption/rot/init
