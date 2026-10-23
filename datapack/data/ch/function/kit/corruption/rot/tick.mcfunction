# As a rot field every tick: follow (bloom), erupt (mire) and every 5 ticks wither what stands on it.
scoreboard players add @s ch.t 1
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run kill @s
tag @a remove ch.caster
function ch:api/tag_owner
execute if score @s ch.v1 matches 1 at @a[tag=ch.caster,limit=1] run tp @s ~ ~ ~
execute if score @s ch.v1 matches 1 unless entity @a[tag=ch.caster,limit=1] run kill @s
execute if score @s ch.v1 matches 2 if score @s ch.t matches 20 at @s run function ch:kit/corruption/rot/erupt
scoreboard players operation #ct ch.tmp = @s ch.t
scoreboard players operation #ct ch.tmp %= #5 ch.g
execute if score #ct ch.tmp matches 0 at @s run function ch:kit/corruption/rot/pulse
tag @a remove ch.caster
