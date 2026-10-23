# As an infection: follows its host, counts down with a quickening heartbeat, then bursts. A host that dies first
# loses the infection - or, with Blight Lord, the infection leaps to the nearest enemy.
scoreboard players add @s ch.t 1
scoreboard players remove @s ch.v1 1
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players operation #chid ch.tmp = @s ch.eid
tag @e[tag=ch.corruption.hcur] remove ch.corruption.hcur
execute as @e[tag=ch.corruption.host,distance=..32] if score @s ch.corruption.hid = #chid ch.tmp run tag @s add ch.corruption.hcur
execute unless entity @e[tag=ch.corruption.hcur,limit=1] run return run function ch:kit/corruption/inf/lost
tp @s @e[tag=ch.corruption.hcur,limit=1]
execute at @s run function ch:kit/corruption/inf/fx
execute if entity @s[tag=ch.corruption.fl] at @s run function ch:kit/corruption/inf/leech
execute if score @s ch.v1 matches ..0 at @s run function ch:kit/corruption/inf/burst
tag @e[tag=ch.corruption.hcur] remove ch.corruption.hcur
tag @a remove ch.caster
