# Black Death (capstone): every enemy hit by a first-generation burst becomes infested too.
scoreboard players set #cgen ch.tmp 1
execute as @e[tag=ch.corruption.bh,tag=!ch.corruption.host,tag=!ch.corruption.hcur,tag=!ch.caster,distance=..12,limit=8] at @s run function ch:kit/corruption/inf/plant
