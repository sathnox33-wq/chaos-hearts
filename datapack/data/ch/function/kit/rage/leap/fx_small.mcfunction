# Level slam VFX: a crater crack, a shockwave, an ember column, debris and a camera hit, then an aftershock.
function ch:api/fx/wave {color:14689835,r:4.0,t:6}
execute positioned ~ ~0.06 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:14689835,s0:1.0,s1:7.0,t:3,life:40,spin:0,dy:0.0}
execute positioned ~ ~0.1 ~ run function ch:api/fx/pillar {model:"beam",color:16738847,w:1.4,h:5.0,t:3,life:8}
particle minecraft:explosion ~ ~0.3 ~ 1.2 0.2 1.2 0 3
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.3 ~ 1.5 0.2 1.5 0.3 70
particle minecraft:block{block_state:"minecraft:netherrack"} ~ ~0.3 ~ 1.2 0.2 1.2 0.3 30
particle minecraft:flame ~ ~0.2 ~ 1.2 0.1 1.2 0.08 30
particle minecraft:lava ~ ~0.3 ~ 1 0.2 1 0 8
function ch:api/fx/shake {s:2,t:8,r:10}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:6}
playsound chaoshearts:rage_slam player @a ~ ~ ~ 1.3 1
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.2 0.7
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 0.6 0.6
function ch:api/later {t:3,then:"ch:kit/rage/leap/after"}
