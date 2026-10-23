# The burning aura: 1.5 damage and fire to enemies within 4 blocks (5.2 with Bigger Blaze).
scoreboard players set #i_dmg ch.tmp 15
scoreboard players set #i_ft ch.tmp 60
execute unless score @s ch.b3 matches 3.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4] at @s run function ch:kit/infernal/sear
execute if score @s ch.b3 matches 3.. as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..5.2] at @s run function ch:kit/infernal/sear
$execute unless score @s ch.b3 matches 3.. rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"ring_soft",color:$(c),s0:7.0,s1:8.2,t:6,life:9,spin:90,dy:0.0}
$execute if score @s ch.b3 matches 3.. rotated 0 0 positioned ~ ~0.1 ~ run function ch:api/fx/sprite {model:"ring_soft",color:$(c),s0:9.4,s1:10.6,t:6,life:9,spin:90,dy:0.0}
playsound minecraft:block.fire.ambient player @a ~ ~ ~ 0.8 0.8
