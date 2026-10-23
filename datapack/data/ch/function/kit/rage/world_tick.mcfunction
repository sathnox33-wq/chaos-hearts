# Rage world tick: fissures, banners, Challenge marks and the kit's persistent displays.
execute if entity @e[type=marker,tag=ch.rage.fis,limit=1] as @e[type=marker,tag=ch.rage.fis] at @s run function ch:kit/rage/fissure/step
execute if entity @e[type=marker,tag=ch.rage.ban,limit=1] as @e[type=marker,tag=ch.rage.ban] at @s run function ch:kit/rage/banner/tick
execute if entity @e[tag=ch.rage.deco,limit=1] as @e[tag=ch.rage.deco] run function ch:kit/rage/deco_tick
execute if score #rmk ch.rage.g matches 1.. run function ch:kit/rage/cry/marks
