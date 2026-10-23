# Down: a cone of bile 7 blocks deep - damage, Poison II and a shove; a small cloud lingers in front of you.
tag @e[tag=ch.corruption.sp] remove ch.corruption.sp
execute rotated ~ 0 positioned ^ ^1 ^1 run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.2] add ch.corruption.sp
execute rotated ~ 0 positioned ^ ^1 ^2.5 run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..1.8] add ch.corruption.sp
execute rotated ~ 0 positioned ^ ^1 ^4 run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.3] add ch.corruption.sp
execute rotated ~ 0 positioned ^ ^1 ^5.6 run tag @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..2.8] add ch.corruption.sp
execute as @e[tag=ch.corruption.sp,distance=..9,limit=12] run function ch:kit/corruption/bolt/spew_hit
tag @e[tag=ch.corruption.sp] remove ch.corruption.sp
playsound minecraft:entity.puffer_fish.blow_out player @a ~ ~ ~ 1.2 0.5
playsound minecraft:entity.llama.spit player @a ~ ~ ~ 1.2 0.5
playsound chaoshearts:corruption_bolt player @a ~ ~ ~ 1 0.7
execute rotated ~ 0 positioned ^ ^1.2 ^1.5 run particle minecraft:dust{color:[0.784,0.831,0.165],scale:1.8} ^ ^ ^ 0.4 0.3 0.4 0 20
execute rotated ~ 0 positioned ^ ^1.1 ^3.5 run particle minecraft:dust{color:[0.482,0.82,0.227],scale:2.0} ^ ^ ^ 0.9 0.5 0.9 0 30
execute rotated ~ 0 positioned ^ ^1 ^5.5 run particle minecraft:dust{color:[0.239,0.102,0.322],scale:2.0} ^ ^ ^ 1.4 0.6 1.4 0 30
execute rotated ~ 0 positioned ^ ^1 ^3 run particle minecraft:item_slime ^ ^ ^ 1.2 0.5 1.2 0.1 30
execute rotated ~ 0 positioned ^ ^1 ^3 run particle minecraft:sneeze ^ ^ ^ 1.4 0.4 1.4 0.05 20
execute rotated ~ 0 positioned ^ ^1.1 ^2 rotated ~ 90 run function ch:api/fx/sprite {model:"cloud",color:13161514,s0:0.5,s1:2.4,t:3,life:7,spin:90,dy:0.0}
execute rotated ~ 0 positioned ^ ^1 ^4.5 rotated ~ 90 run function ch:api/fx/sprite {model:"cloud",color:8114490,s0:0.8,s1:4.2,t:4,life:8,spin:-90,dy:0.0}
execute rotated ~ 0 run function ch:api/fx/slash {color:13161514,s:4.0,roll:0,t:3}
function ch:api/later {t:2,then:"ch:kit/corruption/bolt/spew2"}
scoreboard players set #crad ch.tmp 25
scoreboard players set #clife ch.tmp 40
scoreboard players operation #cwit ch.tmp = #cpest ch.tmp
scoreboard players set #camp ch.tmp 1
execute rotated ~ 0 positioned ^ ^0.5 ^3 run function ch:kit/corruption/cloud/spawn
function ch:api/fx/shake {s:1,t:4,r:4}
return 1
