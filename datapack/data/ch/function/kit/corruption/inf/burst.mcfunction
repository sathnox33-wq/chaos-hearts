# The burst: the host takes full damage, everyone near takes 75%, all get Poison II. Contagion feat, Carrier jump,
# Black Death spread; a self-infestation mends the carrier for each victim.
function ch:kit/corruption/inf/load
scoreboard players operation #cd ch.tmp = @s ch.v4
scoreboard players set #hits ch.tmp 0
tag @e[tag=ch.corruption.bh] remove ch.corruption.bh
execute as @e[tag=ch.corruption.hcur,limit=1] at @s run function ch:kit/corruption/inf/hosthit
scoreboard players operation #cd ch.tmp *= #3 ch.corruption.k
scoreboard players operation #cd ch.tmp /= #4 ch.g
execute store result storage ch:corruption b.r float 0.1 run scoreboard players get @s ch.v3
function ch:kit/corruption/inf/area with storage ch:corruption b
execute if score #hits ch.tmp matches 3.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"corruption",n:2}
execute if entity @s[tag=ch.corruption.fs] as @a[tag=ch.caster,limit=1] run function ch:kit/corruption/inf/mend
scoreboard players add @a[tag=ch.caster,limit=1] ch.corruption.m 10
execute if entity @s[tag=ch.corruption.fc] if score #cgen ch.tmp matches ..1 run function ch:kit/corruption/inf/carrier
execute if entity @s[tag=ch.corruption.fb] if score #cgen ch.tmp matches 0 run function ch:kit/corruption/inf/blackdeath
tag @e[tag=ch.corruption.bh] remove ch.corruption.bh
tag @e[tag=ch.corruption.hcur] remove ch.corruption.host
function ch:kit/corruption/inf/burst_fx
kill @s
