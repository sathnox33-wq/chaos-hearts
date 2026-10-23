# Up: Starstorm. Six smaller stars rain in a pattern around the closest enemy within 24 blocks (or ahead of you).
scoreboard players operation #ce_d ch.tmp /= #2 ch.g
scoreboard players add #ce_d ch.tmp 5
scoreboard players set #ce_r ch.tmp 20
scoreboard players set #ce_sm ch.tmp 1
scoreboard players set #ce_co ch.tmp 0
scoreboard players set #ce_found ch.tmp 0
execute as @e[type=player,tag=!ch.caster,gamemode=!spectator,gamemode=!creative,distance=..24,sort=nearest,limit=1] at @s run function ch:kit/celestial/star/storm_at
execute if score #ce_found ch.tmp matches 0 as @e[type=!#ch:ignore,type=!player,tag=!ch.noability,distance=..24,sort=nearest,limit=1] at @s run function ch:kit/celestial/star/storm_at
execute if score #ce_found ch.tmp matches 0 rotated ~ 0 positioned ^ ^ ^8 run function ch:kit/celestial/star/storm_at
playsound chaoshearts:celestial_ascension player @a ~ ~ ~ 0.8 1.5
return 1
