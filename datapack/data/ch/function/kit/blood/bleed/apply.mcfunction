# As a target, with the Blood holder tagged ch.caster: bleeds for #bt ch.tmp ticks (50% longer with Deep Cuts).
# Bleeding deals 1 damage a second (1.5 from the Blood Moon with Blood Rain). #bm ch.tmp 1 marks a Blood Moon bleed.
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 run return fail
scoreboard players operation #bt2 ch.tmp = #bt ch.tmp
execute if score @a[tag=ch.caster,limit=1] ch.b2 matches 1.. run scoreboard players operation #bt2 ch.tmp *= #3 ch.blood.g
execute if score @a[tag=ch.caster,limit=1] ch.b2 matches 1.. run scoreboard players operation #bt2 ch.tmp /= #2 ch.g
execute unless score @s ch.blood.bleed >= #bt2 ch.tmp run scoreboard players operation @s ch.blood.bleed = #bt2 ch.tmp
scoreboard players operation @s ch.blood.bo = @a[tag=ch.caster,limit=1] ch.pid
scoreboard players operation @s ch.blood.bm = #bm ch.tmp
scoreboard players set #bleeds ch.blood.g 1
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.1 12
return 1
