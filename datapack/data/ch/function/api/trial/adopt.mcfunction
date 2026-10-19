# As a mob a trial just spawned: marks it as part of the trial (removed at cleanup), keeps it from despawning,
# scales its health by #trial_pct and points it at the challenger.
tag @s add ch.tmob
team join ch.trial @s
data merge entity @s {PersistenceRequired:1b}
scoreboard players operation @s ch.slot = #slot ch.tmp
execute store result score #hp ch.tmp run attribute @s minecraft:max_health get 100
scoreboard players operation #hp ch.tmp *= #trial_pct ch.cfg
scoreboard players operation #hp ch.tmp /= #100 ch.g
execute store result storage ch:tmp ad.hp double 0.01 run scoreboard players get #hp ch.tmp
function ch:api/trial/adopt_hp with storage ch:tmp ad
