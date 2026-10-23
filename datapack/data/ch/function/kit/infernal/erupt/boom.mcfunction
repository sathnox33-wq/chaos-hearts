# The eruption: a geyser of magma that launches and burns everything within $(r) blocks for $(d).
$particle $(fl) ~ ~1 ~ 0.6 2.5 0.6 0.15 120
particle minecraft:lava ~ ~0.5 ~ 1 0.3 1 0 40
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
particle minecraft:large_smoke ~ ~3 ~ 1.2 2 1.2 0.05 40
particle minecraft:campfire_signal_smoke ~ ~1 ~ 0.6 0.5 0.6 0.02 8
particle minecraft:block{block_state:"minecraft:magma_block"} ~ ~0.5 ~ 1 0.5 1 0.4 60
$function ch:api/fx/pillar {model:"beam",color:$(c3),w:1.6,h:12.0,t:3,life:14}
$function ch:api/fx/pillar {model:"flame",color:$(c),w:$(dia),h:7.0,t:4,life:14}
$function ch:api/fx/sprite {model:"swirl",color:$(c2),s0:1.0,s1:$(dia),t:8,life:14,spin:170,dy:4.0}
$execute rotated 0 0 run function ch:api/fx/wave {color:$(c),r:$(r),t:6}
$function ch:api/fx/orb {color:$(c3),s:$(dia),t:3,life:8}
$execute rotated 30 -60 run function ch:api/fx/sprite {model:"shard",color:$(c2),s0:0.6,s1:0.2,t:10,life:12,spin:170,dy:5.0}
$execute rotated 150 -70 run function ch:api/fx/sprite {model:"shard",color:$(c2),s0:0.7,s1:0.2,t:10,life:12,spin:170,dy:6.0}
$execute rotated 260 -50 run function ch:api/fx/sprite {model:"shard",color:$(c),s0:0.5,s1:0.2,t:10,life:12,spin:170,dy:4.5}
function ch:api/fx/light {t:8}
function ch:api/fx/shake {s:3,t:12,r:16}
playsound chaoshearts:infernal_eruption player @a ~ ~ ~ 2 1
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.4 0.6
playsound minecraft:entity.magma_cube.squish player @a ~ ~ ~ 1.5 0.5
$scoreboard players set #i_dmg ch.tmp $(d)
scoreboard players set #i_ft ch.tmp 100
$execute positioned ~ ~1 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..$(r)] run function ch:kit/infernal/erupt/boom_one
