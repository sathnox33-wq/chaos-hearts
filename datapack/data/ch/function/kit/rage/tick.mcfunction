# Rage, every tick for its holders: Fury upkeep and states, leap flight, Berserk, Rampage, low-health heartbeat, aura.
scoreboard players operation #r2 ch.tmp = #now ch.g
scoreboard players operation #r2 ch.tmp %= #2 ch.g
scoreboard players operation #r4 ch.tmp = #now ch.g
scoreboard players operation #r4 ch.tmp %= #4 ch.g
scoreboard players add @s ch.rage.calm 1
execute if score @s ch.rage.dealt matches 1.. run function ch:kit/rage/fury/dealt
execute if score @s ch.rage.calm matches 80.. if score @s ch.rage.fury matches 1.. unless score @s ch.rage.ramp matches 1.. run function ch:kit/rage/fury/decay
execute if score @s ch.rage.fury matches 50.. unless score @s ch.rage.s50 matches 1 run function ch:kit/rage/fury/on50
execute if score @s ch.rage.fury matches ..49 if score @s ch.rage.s50 matches 1 run function ch:kit/rage/fury/off50
execute if score @s ch.awake matches 1 if score @s ch.rage.fury matches 101.. unless score @s ch.rage.s100 matches 1 run function ch:kit/rage/fury/on100
execute if score @s ch.rage.s100 matches 1 unless score @s ch.rage.fury matches 101.. run function ch:kit/rage/fury/off100
execute if score @s ch.rage.s100 matches 1 if score #r2 ch.tmp matches 0 run function ch:kit/rage/fury/wrath_fx
execute if score @s ch.rage.leap matches 1.. run function ch:kit/rage/leap/fly
execute if score @s ch.rage.safe matches 1.. run function ch:kit/rage/leap/safe
execute if score @s ch.rage.ava matches 1.. run function ch:kit/rage/leap/ava_tick
execute if score @s ch.rage.bzt matches 1.. run function ch:kit/rage/berserk/tick
execute if score @s ch.rage.ramp matches 1.. run function ch:kit/rage/rampage/tick
execute if score @s ch.rage.bl matches 1.. run scoreboard players remove @s ch.rage.bl 1
execute if score @s ch.rage.und matches 1.. run scoreboard players remove @s ch.rage.und 1
execute if score @s ch.rage.rcd matches 1.. run scoreboard players remove @s ch.rage.rcd 1
execute if score @s ch.rage.cry matches 1.. run scoreboard players remove @s ch.rage.cry 1
execute if score #t20 ch.g matches 0 if score @s ch.health matches ..8 run function ch:kit/rage/heartbeat
execute if score @s ch.lvl matches 90.. if score #r4 ch.tmp matches 0 run function ch:kit/rage/aura
