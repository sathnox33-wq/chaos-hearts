# The fracture opens: a white flash, a gyroscope cage of rings, twelve hour runes and glass shards frozen in the air.
function ch:api/fx/sprite {model:"orb",color:16777215,s0:0.3,s1:4.0,t:2,life:6,spin:0,dy:0.0}
$execute rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:2741234,s0:0.5,s1:$(d),t:6,life:12,spin:90,dy:0.0}
$function ch:api/fx/wave {color:2741234,r:$(r),t:10}
$execute positioned ~ ~1 ~ rotated 0 90 run function ch:api/fx/sprite {model:"ring",color:2741234,s0:0.3,s1:$(d),t:10,life:$(life),spin:40,dy:0.0}
$execute positioned ~ ~1 ~ rotated 60 90 run function ch:api/fx/sprite {model:"ring",color:16113986,s0:0.3,s1:$(d),t:12,life:$(life),spin:40,dy:0.0}
$execute positioned ~ ~1 ~ rotated 120 90 run function ch:api/fx/sprite {model:"ring_soft",color:2741234,s0:0.3,s1:$(d),t:14,life:$(life),spin:40,dy:0.0}
$execute positioned ~ ~0.05 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring_soft",color:2741234,s0:0.3,s1:$(d),t:10,life:$(life),spin:170,dy:0.0}
$execute rotated 0 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.1,s1:1.3,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 30 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 60 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 90 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.1,s1:1.3,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 120 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 150 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 180 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.1,s1:1.3,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 210 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 240 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 270 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.1,s1:1.3,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 300 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 330 0 positioned ^ ^0.05 ^$(rr) run function ch:api/fx/sprite {model:"rune",color:16771466,s0:0.1,s1:0.8,t:10,life:$(life),spin:120,dy:0.0}
$execute rotated 20 0 positioned ^ ^2.2 ^$(r6) run function ch:api/fx/sprite {model:"shard",color:15267583,s0:0.1,s1:0.6,t:8,life:$(life),spin:170,dy:0.4}
$execute rotated 95 0 positioned ^ ^1.1 ^$(r6) run function ch:api/fx/sprite {model:"shard",color:2741234,s0:0.1,s1:0.5,t:8,life:$(life),spin:-150,dy:0.3}
$execute rotated 170 0 positioned ^ ^2.8 ^$(r6) run function ch:api/fx/sprite {model:"shard",color:15267583,s0:0.1,s1:0.7,t:8,life:$(life),spin:160,dy:0.5}
$execute rotated 250 0 positioned ^ ^1.6 ^$(r6) run function ch:api/fx/sprite {model:"shard",color:16777215,s0:0.1,s1:0.5,t:8,life:$(life),spin:-170,dy:0.3}
$execute rotated 320 0 positioned ^ ^2.4 ^$(r6) run function ch:api/fx/sprite {model:"shard",color:2741234,s0:0.1,s1:0.6,t:8,life:$(life),spin:150,dy:0.4}
$execute rotated 60 0 positioned ^ ^3.2 ^$(r3) run function ch:api/fx/sprite {model:"shard",color:16777215,s0:0.1,s1:0.4,t:8,life:$(life),spin:170,dy:0.2}
$execute rotated 200 0 positioned ^ ^1.4 ^$(r3) run function ch:api/fx/sprite {model:"shard",color:15267583,s0:0.1,s1:0.45,t:8,life:$(life),spin:-160,dy:0.3}
$execute rotated 290 0 positioned ^ ^2.6 ^$(r3) run function ch:api/fx/sprite {model:"shard",color:16113986,s0:0.1,s1:0.4,t:8,life:$(life),spin:140,dy:0.2}
$execute positioned ~ ~3.5 ~ rotated 0 0 run function ch:api/fx/sprite {model:"star",color:16771466,s0:0.1,s1:1.2,t:8,life:$(life),spin:170,dy:0.0}
particle minecraft:end_rod ~ ~1.5 ~ 2 1.5 2 0.02 60
playsound chaoshearts:speed_timefracture player @a ~ ~ ~ 1.6 1
playsound minecraft:block.bell.resonate player @a ~ ~ ~ 1.5 0.5
playsound minecraft:block.beacon.deactivate player @a ~ ~ ~ 1 0.5
$function ch:api/fx/shake {s:2,t:10,r:$(r)}
