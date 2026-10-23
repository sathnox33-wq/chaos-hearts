# Displace. Level: swap places with the target (Oblivion: hurl it into the sky). Up: rip it through a rift to your
# feet, rooted. Down: swap, and a rift under its new spot collapses 1.5 s later unless it gets out.
scoreboard players operation #vvar ch.tmp = #var ch.tmp
function ch:api/ray {range:20}
execute unless entity @e[tag=ch.target,limit=1] run return run function ch:kit/void/disp/none
tag @e[tag=ch.void.dt] remove ch.void.dt
tag @e[tag=ch.target,limit=1] add ch.void.dt
tag @e[tag=ch.target] remove ch.target
execute store success score #ver ch.tmp if score @s ch.b3 matches 4..
scoreboard players set #vls ch.tmp 44
execute anchored eyes positioned ^ ^ ^0.6 anchored feet facing entity @e[tag=ch.void.dt,limit=1] eyes run function ch:kit/void/disp/line
playsound chaoshearts:void_displace player @a ~ ~ ~ 1 1
execute at @e[tag=ch.void.dt,limit=1] run playsound chaoshearts:void_displace player @a ~ ~ ~ 1 0.8
execute if score #vvar ch.tmp matches 1 run function ch:kit/void/disp/grab
execute if score #vvar ch.tmp matches 0 if score @s ch.b3 matches 5.. run function ch:kit/void/disp/oblivion
execute if score #vvar ch.tmp matches 0 unless score @s ch.b3 matches 5.. run function ch:kit/void/disp/swap
execute if score #vvar ch.tmp matches 2 run function ch:kit/void/disp/swap
execute if score #vvar ch.tmp matches 2 at @e[tag=ch.void.dt,limit=1] run function ch:kit/void/disp/trap
execute as @e[tag=ch.void.dt,limit=1] at @s run function ch:kit/void/disp/daze
scoreboard players set @s ch.void.swt 100
tag @e[tag=ch.void.dt] remove ch.void.dt
return 1
