# Eruption, moving: a fissure races 15 blocks ahead; six geysers erupt in sequence along it.
data modify storage ch:tmp ki merge value {r:2.2,dia:4.4,rh:1.0,d:60}
data modify storage ch:tmp ki.t set value 12
execute rotated ~ 0 positioned ^ ^ ^3 run function ch:kit/infernal/erupt/fis_mark
data modify storage ch:tmp ki.t set value 15
execute rotated ~ 0 positioned ^ ^ ^5.5 run function ch:kit/infernal/erupt/fis_mark
data modify storage ch:tmp ki.t set value 18
execute rotated ~ 0 positioned ^ ^ ^8 run function ch:kit/infernal/erupt/fis_mark
data modify storage ch:tmp ki.t set value 21
execute rotated ~ 0 positioned ^ ^ ^10.5 run function ch:kit/infernal/erupt/fis_mark
data modify storage ch:tmp ki.t set value 24
execute rotated ~ 0 positioned ^ ^ ^13 run function ch:kit/infernal/erupt/fis_mark
data modify storage ch:tmp ki.t set value 27
execute rotated ~ 0 positioned ^ ^ ^15.5 run function ch:kit/infernal/erupt/fis_mark
playsound chaoshearts:infernal_rumble player @a ~ ~ ~ 1.4 1.3
playsound minecraft:block.basalt.break player @a ~ ~ ~ 1.2 0.5
function ch:api/fx/shake {s:1,t:6,r:10}
return 1
