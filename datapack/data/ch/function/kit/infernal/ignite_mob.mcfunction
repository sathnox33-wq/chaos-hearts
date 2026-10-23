# Sets a mob's fire ticks to #i_ft unless it already burns longer.
execute store result score #i_f ch.tmp run data get entity @s Fire
execute if score #i_f ch.tmp < #i_ft ch.tmp store result entity @s Fire short 1 run scoreboard players get #i_ft ch.tmp
