# Intro beat: the arena floor heaves in a ring of slabs and dust.
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring16
function ch:api/fx/wave {color:13214812,r:14,t:20}
particle minecraft:campfire_cosy_smoke ~ ~0.5 ~ 8 0.3 8 0.02 40
playsound chaoshearts:titan_slam master @a[tag=ch.challenger] ~ ~ ~ 1.2 0.6
playsound minecraft:block.deepslate.break master @a[tag=ch.challenger] ~ ~ ~ 1 0.4
