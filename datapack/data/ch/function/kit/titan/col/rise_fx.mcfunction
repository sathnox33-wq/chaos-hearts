# The Colossus rises: a pillar of gold, double shockwave, the ground heaving in a ring, the world shaking.
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:13214812,w:2.2,h:16.0,t:6,life:20}
execute rotated 0 0 run function ch:api/fx/pillar {model:"beam",color:16757575,w:0.8,h:22.0,t:4,life:16}
function ch:api/fx/wave {color:13214812,r:8,t:10}
scoreboard players set #ti_d ch.tmp 0
scoreboard players set #ti_cid ch.tmp 0
scoreboard players set #ti_big ch.tmp 1
scoreboard players set #ti_x ch.tmp 0
scoreboard players set #ti_cat ch.tmp 0
function ch:kit/titan/fx/later {t:5,then:"ch:kit/titan/col/rise_fx2"}
function ch:kit/titan/fx/ring12
function ch:kit/titan/fx/debris
execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:13214812,s0:1.0,s1:9.0,t:10,life:30,spin:170,dy:0.0}
execute positioned ~ ~0.04 ~ rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:1.0,s1:7.0,t:4,life:60,spin:0,dy:0.0}
particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 2 1 2 0.3 120
particle minecraft:dust{color:[0.788,0.643,0.361],scale:2.5} ~ ~1 ~ 2.5 1.5 2.5 0 80
particle minecraft:campfire_cosy_smoke ~ ~0.5 ~ 2 0.3 2 0.04 20
playsound chaoshearts:titan_colossus player @a ~ ~ ~ 2 1
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.iron_golem.repair player @a ~ ~ ~ 1.5 0.5
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1.5 0.5
function ch:api/fx/shake {s:3,t:20,r:16}
execute positioned ~ ~2 ~ run function ch:api/fx/light {t:10}
execute unless score @s ch.titan.colm matches 2 run function ch:kit/titan/fx/banner {o:"titan",color:"#C9A45C",in:2,stay:30,out:12,sub:"⛰ COLOSSUS ⛰",subc:"#C9A45C"}
execute if score @s ch.titan.colm matches 2 run function ch:kit/titan/fx/banner {o:"titan",color:"#C9A45C",in:2,stay:30,out:12,sub:"⛰ BASTION ⛰",subc:"#C9A45C"}
