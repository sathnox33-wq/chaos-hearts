# Once a second, as an entity an Infernal player set alight: forget it when the fire is out; Hellfire burns it for 1.
execute if score @s ch.infernal.lu < #now ch.g run return run tag @s remove ch.infernal.lit
execute store result score #i_f ch.tmp run data get entity @s Fire
execute if score #i_f ch.tmp matches ..0 run return run tag @s remove ch.infernal.lit
tag @a remove ch.caster
scoreboard players operation #i_o ch.tmp = @s ch.infernal.by
execute as @a if score @s ch.pid = #i_o ch.tmp run tag @s add ch.caster
execute if entity @a[tag=ch.caster,scores={ch.active=3,ch.awake=1},limit=1] run function ch:kit/infernal/hellfire
tag @a remove ch.caster
