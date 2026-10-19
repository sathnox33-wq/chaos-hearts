# Runs the FX displays. #fx stays 1 while any exist.
scoreboard players set #fx ch.g 0
execute as @e[tag=ch.fx] run function ch:api/fx/tick
execute if entity @e[tag=ch.fx,limit=1] run scoreboard players set #fx ch.g 1
