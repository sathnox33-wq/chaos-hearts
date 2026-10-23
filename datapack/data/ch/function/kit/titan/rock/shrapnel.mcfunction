# Down: Shrapnel. Smash a boulder at your feet into a fan of seven stone shards (eleven with World Breaker).
scoreboard players set #ti_big ch.tmp 0
function ch:kit/titan/fx/ground
data modify storage ch:tmp trk.b set from storage ch:tmp tg.b
execute rotated ~ 0 positioned ^ ^ ^1 run function ch:kit/titan/fx/debris
execute rotated ~ 0 positioned ^ ^0.1 ^1.2 rotated ~ 0 run function ch:api/fx/sprite {model:"crack",color:16742954,s0:0.4,s1:2.6,t:3,life:30,spin:0,dy:0.0}
execute rotated ~ 0 run function ch:api/fx/slash {color:8025194,s:3.5,roll:0,t:3}
particle minecraft:explosion ^ ^0.5 ^1.2 0.2 0.1 0.2 0 2
playsound minecraft:item.mace.smash_ground_heavy player @a ~ ~ ~ 1 0.8
playsound minecraft:block.stone.break player @a ~ ~ ~ 1.5 0.6
playsound chaoshearts:titan_boulder player @a ~ ~ ~ 0.8 1.4
function ch:api/fx/shake {s:2,t:5,r:6}
data modify storage ch:tmp trk.p set value -4
execute unless score @s ch.b3 matches 5.. run function ch:kit/titan/rock/fan7
execute if score @s ch.b3 matches 5.. run function ch:kit/titan/rock/fan11
return 1
