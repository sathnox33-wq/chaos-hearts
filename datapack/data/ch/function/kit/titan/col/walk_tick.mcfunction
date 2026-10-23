# Colossus footsteps: the ground shakes every step; with Quake Step they hurt enemies within 3 blocks.
scoreboard players set #ti_mv ch.tmp 0
execute if predicate ch:input/forward run scoreboard players set #ti_mv ch.tmp 1
execute if predicate ch:input/backward run scoreboard players set #ti_mv ch.tmp 1
execute if predicate ch:input/left run scoreboard players set #ti_mv ch.tmp 1
execute if predicate ch:input/right run scoreboard players set #ti_mv ch.tmp 1
execute unless score #ti_mv ch.tmp matches 1 run return 0
execute unless predicate ch:on_ground run return 0
scoreboard players operation #ti_m ch.tmp = @s ch.titan.col
scoreboard players operation #ti_m ch.tmp %= #10 ch.g
execute unless score #ti_m ch.tmp matches 0 run return 0
execute if score @s ch.b1 matches 4.. run return run function ch:kit/titan/col/quake
function ch:kit/titan/fx/debris
playsound minecraft:entity.ravager.step player @a ~ ~ ~ 1 0.6
function ch:api/fx/shake {s:1,t:3,r:6}
