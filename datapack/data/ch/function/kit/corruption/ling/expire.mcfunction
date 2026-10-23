# A rotling falls apart; with Hive Mind it bursts into a plague cloud.
tag @a remove ch.caster
function ch:api/tag_owner
particle minecraft:sculk_soul ~ ~1 ~ 0.3 0.5 0.3 0.05 12
particle minecraft:dust{color:[0.239,0.102,0.322],scale:1.6} ~ ~1 ~ 0.3 0.5 0.3 0 20
playsound minecraft:entity.husk.death player @a ~ ~ ~ 0.8 0.6
scoreboard players set #crad ch.tmp 25
scoreboard players set #clife ch.tmp 60
scoreboard players set #camp ch.tmp 0
scoreboard players set #cwit ch.tmp 0
execute if score @s ch.v2 matches 1 positioned ~ ~0.6 ~ run function ch:kit/corruption/cloud/spawn
execute if score @s ch.v2 matches 1 run playsound chaoshearts:corruption_burst player @a ~ ~ ~ 0.8 1.4
tag @a remove ch.caster
tp @s ~ -300 ~
kill @s
