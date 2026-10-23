# Second link: the ground cracks under the victim.
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:14689835,r:3.0,t:5}
execute positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:14689835,s0:0.5,s1:4.0,t:2,life:24,spin:0,dy:0.0}
execute positioned ~ ~1 ~ run function ch:api/fx/orb {color:16738847,s:2.0,t:2,life:5}
particle minecraft:crit ~ ~1 ~ 0.5 0.5 0.5 0.6 26
particle minecraft:block{block_state:"minecraft:blackstone"} ~ ~0.3 ~ 0.6 0.1 0.6 0.2 20
function ch:api/fx/shake {s:1,t:4,r:6}
playsound minecraft:entity.player.attack.crit player @a ~ ~ ~ 1 0.6
playsound minecraft:block.anvil.land player @a ~ ~ ~ 0.35 1.1
