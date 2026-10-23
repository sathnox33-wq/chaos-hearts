# Later: the pustule bursts - 6 damage within 3 blocks and Poison II.
kill @e[type=block_display,tag=ch.corruption.tpus,distance=..1.5,limit=1,sort=nearest]
execute as @a[tag=ch.challenger,distance=..3] run function ch:trials/corruption/strike {d:60}
effect give @a[tag=ch.challenger,distance=..3] minecraft:poison 4 1
particle minecraft:item_slime ~ ~1 ~ 0.8 0.6 0.8 0.3 50
particle minecraft:dust{color:[0.482,0.82,0.227],scale:2.4} ~ ~1 ~ 1.4 0.8 1.4 0 50
particle minecraft:explosion ~ ~1 ~ 0 0 0 0 1
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:13161514,s:5.0,t:3,life:6}
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:8114490,r:3.5,t:5}
playsound chaoshearts:corruption_burst hostile @a ~ ~ ~ 1.5 0.8
playsound minecraft:entity.slime.death hostile @a ~ ~ ~ 1.5 0.5
function ch:api/fx/shake {s:2,t:6,r:10}
