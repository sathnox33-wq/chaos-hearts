# Glacial Lance (full Frost): a hitscan spear of ice through everything for 40 blocks; 11 damage and frozen solid.
scoreboard players set @s ch.frozen.frost 0
scoreboard players set #f_ls ch.tmp 80
scoreboard players set #f_dmg ch.tmp 110
execute anchored eyes positioned ^ ^ ^0.5 run function ch:kit/frozen/shard/lance_step
tag @e[tag=ch.frozen.lh] remove ch.frozen.lh
execute anchored eyes positioned ^ ^-0.1 ^0.4 run function ch:api/fx/beam {color:10217471,w:0.7,len:40.0,t:3,life:12}
execute anchored eyes positioned ^ ^-0.1 ^0.4 run function ch:api/fx/beam {color:15924223,w:0.25,len:40.0,t:2,life:14}
execute anchored eyes positioned ^ ^ ^1.5 rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:15924223,s0:0.5,s1:4.0,t:4,life:8,spin:150,dy:0.0}
execute anchored eyes positioned ^ ^ ^6 rotated ~ 90 run function ch:api/fx/sprite {model:"ring",color:10217471,s0:0.5,s1:3.0,t:5,life:9,spin:-150,dy:0.0}
execute anchored eyes positioned ^ ^ ^12 rotated ~ 90 run function ch:api/fx/sprite {model:"hex",color:6273256,s0:0.5,s1:2.4,t:6,life:10,spin:150,dy:0.0}
function ch:api/fx/screen {o:"flash",color:"#C8F0FF",in:0,stay:2,out:8}
function ch:api/fx/shake {s:2,t:6,r:6}
playsound chaoshearts:frozen_shard player @a ~ ~ ~ 1.6 0.5
playsound minecraft:block.beacon.deactivate player @a ~ ~ ~ 1 1.6
playsound minecraft:block.glass.break player @a ~ ~ ~ 1 0.5
return 1
