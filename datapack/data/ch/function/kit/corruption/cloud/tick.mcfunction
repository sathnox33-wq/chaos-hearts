# As a plague cloud: every 5 ticks it churns and poisons everything inside it; Patient Zero counts its victims.
scoreboard players add @s ch.t 1
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #5 ch.g
execute unless score #ct ch.tmp matches 0 run return 0
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players operation #ccid ch.tmp = @s ch.eid
tag @s add ch.corruption.ccur
execute store result storage ch:corruption c.r float 0.1 run scoreboard players get @s ch.v2
execute store result storage ch:corruption c.h float 0.045 run scoreboard players get @s ch.v2
function ch:kit/corruption/cloud/pulse with storage ch:corruption c
execute if score @s ch.v3 matches 5.. as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"corruption",n:0}
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #20 ch.g
execute if score #ct ch.tmp matches 0 rotated 0 0 run function ch:api/fx/sprite {model:"cloud",color:8114490,s0:2.0,s1:3.2,t:18,life:22,spin:120,dy:0.3}
execute if score #ct ch.tmp matches 10 rotated 45 0 run function ch:api/fx/sprite {model:"cloud",color:4004434,s0:1.6,s1:2.6,t:18,life:22,spin:-120,dy:0.5}
tag @s remove ch.corruption.ccur
tag @a remove ch.caster
