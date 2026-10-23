# Phase 2+: Gorrath's fury rains as burning rock: one on the challenger, two near them, after 1.5 s of warning.
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.rage.met","ch.rage.mnew","ch.tmob","ch.noability"]}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.rage.met","ch.rage.mnew","ch.rage.mspread","ch.tmob","ch.noability"]}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run summon marker ~ ~ ~ {Tags:["ch.rage.met","ch.rage.mnew","ch.rage.mspread","ch.tmob","ch.noability"]}
execute at @a[tag=ch.challenger,distance=..80,limit=1] run spreadplayers ~ ~ 2 6 under 104 false @e[type=marker,tag=ch.rage.mspread,tag=ch.rage.mnew]
execute as @e[type=marker,tag=ch.rage.mnew] at @s run function ch:trials/rage/met_mark
tag @e[type=marker,tag=ch.rage.mnew] remove ch.rage.mnew
function ch:trials/rage/say {m:"The sky burns! Move!"}
playsound minecraft:entity.ravager.roar master @a[distance=..90] ~ ~ ~ 2 1.4
