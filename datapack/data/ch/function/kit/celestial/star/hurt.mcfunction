# A star hits this target: damage, Glowing, Starburn's slow, a comet's or nova's knockback, feats and Starlight.
scoreboard players set #ce_air ch.tmp 0
execute unless predicate ch:on_ground run scoreboard players set #ce_air ch.tmp 1
execute store result score #ce_ok ch.tmp run function ch:kit/celestial/hit
execute unless score #ce_ok ch.tmp matches 1.. run return 0
effect give @s minecraft:glowing 5 0 true
execute if entity @a[tag=ch.caster,scores={ch.b1=3..},limit=1] run function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
execute if score #ce_co ch.tmp matches 1 run function ch:api/push {s:1.2,y:0.5}
execute if score #ce_nv ch.tmp matches 1 run function ch:api/push {s:0.9,y:0.4}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"celestial",color:"#FFF2B0",in:1,stay:2,out:10}
particle minecraft:end_rod ~ ~1 ~ 0.3 0.5 0.3 0.05 8
execute if score #ce_air ch.tmp matches 1 if score #ce_sm ch.tmp matches 0 as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"celestial",n:0}
execute if score #ce_as ch.tmp matches 1 as @a[tag=ch.caster,limit=1] run function ch:kit/celestial/asc/count
scoreboard players add @a[tag=ch.caster,limit=1] ch.celestial.sl 4
