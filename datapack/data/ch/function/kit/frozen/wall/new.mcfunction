# One temporary ice block marker: appears after #f_dl ticks, melts after #f_dur.
summon minecraft:marker ~ ~ ~ {Tags:["ch.frozen.ice","ch.noability","ch.frozen.inew"]}
scoreboard players operation @e[type=marker,tag=ch.frozen.inew,limit=1] ch.v1 = #f_dl ch.tmp
scoreboard players operation @e[type=marker,tag=ch.frozen.inew,limit=1] ch.life = #f_dur ch.tmp
tag @e[type=marker,tag=ch.frozen.inew] remove ch.frozen.inew
