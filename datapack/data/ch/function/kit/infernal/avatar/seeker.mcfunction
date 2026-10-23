# Hurls a seeking fireball at the nearest enemy within 16 blocks.
execute unless entity @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..16,limit=1] run return 0
tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..16,sort=nearest,limit=1] add ch.infernal.st2
execute as @e[tag=ch.infernal.st2,limit=1] run function ch:kit/infernal/volley/lock2
scoreboard players set #i_kind ch.tmp 3
scoreboard players set #i_dmg ch.tmp 30
execute if score @s ch.b1 matches 1.. run function ch:kit/infernal/mul_dmg
function ch:kit/infernal/volley/launch
execute as @e[type=item_display,tag=ch.infernal.np,limit=1] at @s facing entity @e[tag=ch.infernal.st2,limit=1] eyes run tp @s ~ ~ ~ ~ ~
function ch:kit/infernal/volley/done
tag @e[tag=ch.infernal.st2] remove ch.infernal.st2
scoreboard players set @s ch.infernal.sk 0
playsound minecraft:entity.blaze.shoot player @a ~ ~ ~ 0.6 1.3
