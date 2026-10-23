# Moonfall impact (as the moon): 10 damage within 2.5, 7 to 5.5, a 6 s bleed, everyone thrown; then the owner gets a 6 s Blood Moon.
tag @a remove ch.caster
function ch:api/tag_owner
scoreboard players set #bt ch.tmp 120
scoreboard players set #bm ch.tmp 1
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.5] run function ch:kit/blood/moon/impact_hit {d:100}
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=2.51..5.5] run function ch:kit/blood/moon/impact_hit {d:70}
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
function ch:api/fx/wave {color:10357535,r:6.0,t:6}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16723263,s0:2.0,s1:12.0,t:3,life:50,spin:0,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16723263,s:8.0,t:3,life:7}
function ch:api/fx/pillar {model:"beam",color:10357535,w:3.0,h:16.0,t:3,life:10}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 3 1 3 0.5 150
particle minecraft:block{block_state:"minecraft:netherrack"} ~ ~0.5 ~ 3 0.5 3 0.4 60
function ch:api/fx/shake {s:3,t:16,r:20}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:10}
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 2 0.5
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 1 0.5
playsound chaoshearts:blood_moon player @a ~ ~ ~ 2 0.8
function ch:api/later {t:4,then:"ch:kit/blood/moon/impact2"}
execute as @a[tag=ch.caster,limit=1] at @s run function ch:kit/blood/moon/rise {t:120}
tag @a remove ch.caster
kill @s
