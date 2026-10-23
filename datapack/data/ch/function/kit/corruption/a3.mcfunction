# Infest. Level: plant an infection in the target; it bursts after 4 s, spreading. Up: infest yourself - you become a
# walking plague bomb with a double-size burst (you are immune) that mends you per victim. Down: a leeching infection
# tethered to you - it drains the host each second and bursts early if the host breaks the tether (14 blocks).
scoreboard players operation #cvar ch.tmp = #var ch.tmp
scoreboard players set #cgen ch.tmp 0
scoreboard players set #cfuse ch.tmp 80
execute if score @s ch.b3 matches 1.. run scoreboard players set #cfuse ch.tmp 60
scoreboard players set #crad ch.tmp 30
execute if score @s ch.b3 matches 2.. run scoreboard players set #crad ch.tmp 42
scoreboard players set #cdmg ch.tmp 60
execute store success score #cfc ch.tmp if score @s ch.b3 matches 4..
execute store success score #cfb ch.tmp if score @s ch.b3 matches 5..
execute store success score #cfa ch.tmp if score @s ch.awake matches 1
execute store success score #cnec ch.tmp if score @s ch.b1 matches 4..
scoreboard players set #cfl ch.tmp 0
scoreboard players set #cfs ch.tmp 0
execute if score #cvar ch.tmp matches 1 run return run function ch:kit/corruption/inf/self
function ch:api/ray {range:16}
execute unless entity @e[tag=ch.target,limit=1] run return run function ch:kit/corruption/inf/none
execute as @e[tag=ch.target,tag=ch.corruption.host,limit=1] run function ch:kit/corruption/inf/check_live
execute if entity @e[tag=ch.target,tag=ch.corruption.host,limit=1] run return run function ch:kit/corruption/inf/already
execute if score #cvar ch.tmp matches 2 run scoreboard players set #cfl ch.tmp 1
execute if score #cvar ch.tmp matches 2 run scoreboard players set #cfuse ch.tmp 100
scoreboard players set #cls ch.tmp 34
execute anchored eyes positioned ^ ^ ^0.6 anchored feet facing entity @e[tag=ch.target,limit=1] eyes run function ch:kit/corruption/inf/line
playsound chaoshearts:corruption_infest player @a ~ ~ ~ 1 1
playsound minecraft:entity.evoker.cast_spell player @a ~ ~ ~ 0.8 0.6
execute as @e[tag=ch.target,limit=1] at @s run function ch:kit/corruption/inf/plant
tag @e[tag=ch.target] remove ch.target
return 1
