# Players cannot be given fire ticks by command: a flash of real fire at their feet lights them, removed 3 ticks later.
execute if block ~ ~ ~ #minecraft:air run setblock ~ ~ ~ minecraft:fire
execute if block ~ ~ ~ minecraft:fire run function ch:api/later {t:3,then:"ch:kit/infernal/unfire"}
