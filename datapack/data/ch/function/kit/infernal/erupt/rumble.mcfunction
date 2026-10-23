# The ground shudders and glows; on the last rumble it erupts.
scoreboard players remove @s ch.v1 1
function ch:kit/infernal/erupt/rumble_fx with entity @s data.e
execute if score @s ch.v1 matches ..0 run return run function ch:kit/infernal/erupt/boom with entity @s data.e
data modify storage ch:tmp ki set from entity @s data.e
function ch:api/later {t:4,then:"ch:kit/infernal/erupt/rumble"}
data modify entity @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] data.e set from storage ch:tmp ki
scoreboard players operation @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] ch.v1 = @s ch.v1
tag @e[type=marker,tag=ch.lnew] remove ch.lnew
