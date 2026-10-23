# Skyfall / Wrathfall impact: a meteor strike. Twin cracks, a rune flare, a towering flame column, three shockwaves.
function ch:api/fx/wave {color:14689835,r:6.0,t:6}
execute positioned ~ ~0.06 ~ rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:14689835,s0:1.0,s1:11.0,t:3,life:50,spin:0,dy:0.0}
execute positioned ~ ~0.07 ~ rotated ~45 0 run function ch:api/fx/sprite {model:"crack",color:3801088,s0:1.0,s1:8.0,t:4,life:50,spin:0,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16738847,s0:12.0,s1:2.0,t:10,life:14,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ run function ch:api/fx/pillar {model:"flame",color:16738847,w:3.0,h:9.0,t:3,life:10}
execute positioned ~ ~0.1 ~ run function ch:api/fx/pillar {model:"beam",color:14689835,w:2.0,h:14.0,t:3,life:9}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:3801088,s:5.0,t:3,life:7}
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.3 ~ 2.5 0.3 2.5 0.4 120
particle minecraft:block{block_state:"minecraft:magma_block"} ~ ~0.3 ~ 2 0.3 2 0.4 50
particle minecraft:lava ~ ~0.5 ~ 2 0.3 2 0 20
particle minecraft:flame ~ ~0.2 ~ 2.5 0.1 2.5 0.12 60
function ch:api/fx/shake {s:3,t:14,r:16}
function ch:api/fx/screen {o:"rage",color:"#E0262B",in:0,stay:4,out:12}
execute positioned ~ ~1 ~ run function ch:api/fx/light {t:10}
playsound chaoshearts:rage_slam player @a ~ ~ ~ 2 0.8
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.6 0.5
playsound minecraft:entity.generic.explode player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 0.6 0.6
function ch:api/later {t:3,then:"ch:kit/rage/leap/after"}
function ch:api/later {t:7,then:"ch:kit/rage/leap/after2"}
