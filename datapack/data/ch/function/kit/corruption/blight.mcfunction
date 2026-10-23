# As the struck enemy: stack Blight (resets after 5 s without a hit); at 3 stacks (2 with Feverish) it is Poison II.
execute unless score @s ch.corruption.blt = @s ch.corruption.blt run scoreboard players set @s ch.corruption.blt -1000
scoreboard players operation #cn ch.tmp = #now ch.g
scoreboard players operation #cn ch.tmp -= @s ch.corruption.blt
execute if score #cn ch.tmp matches 101.. run scoreboard players set @s ch.corruption.bl 0
scoreboard players add @s ch.corruption.bl 1
scoreboard players operation @s ch.corruption.blt = #now ch.g
scoreboard players set #cneed ch.tmp 3
execute if entity @a[tag=ch.caster,scores={ch.b3=3..},limit=1] run scoreboard players set #cneed ch.tmp 2
execute if score @s ch.corruption.bl < #cneed ch.tmp run function ch:kit/corruption/poison {sec:3,amp:0}
execute if score @s ch.corruption.bl >= #cneed ch.tmp run function ch:kit/corruption/blight_max
scoreboard players add @a[tag=ch.caster,limit=1] ch.corruption.m 6
scoreboard players set @a[tag=ch.caster,limit=1] ch.corruption.mt 100
particle minecraft:dust{color:[0.482,0.82,0.227],scale:1.2} ~ ~1.2 ~ 0.3 0.4 0.3 0 8
particle minecraft:sneeze ~ ~1.2 ~ 0.2 0.3 0.2 0.02 3
