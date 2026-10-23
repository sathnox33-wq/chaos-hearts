# Caught in a Frost Nova: damage, frozen solid, Ice Prison with the capstone.
scoreboard players operation #f_dmg ch.tmp = #f_nd ch.tmp
execute store result score #f_ok ch.tmp run function ch:kit/frozen/hurt
execute if score #f_ok ch.tmp matches 0 run return 0
scoreboard players operation #f_ft ch.tmp = #f_nf ch.tmp
function ch:kit/frozen/freeze
execute unless entity @s[type=player] run data modify entity @s TicksFrozen set value 300
execute if entity @a[tag=ch.caster,scores={ch.active=5,ch.b1=5..},limit=1] run function ch:kit/frozen/nova/prison
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.3 0.5 0.3 0.1 16
