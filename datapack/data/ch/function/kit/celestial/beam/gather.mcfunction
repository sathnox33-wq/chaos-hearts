# The windup: light pours into the Celestial's hands with a rising tone.
execute anchored eyes positioned ^ ^-0.2 ^0.8 run function ch:api/fx/orb {color:16777215,s:0.9,t:6,life:8}
execute anchored eyes positioned ^ ^-0.2 ^0.8 rotated ~ ~ run function ch:api/fx/sprite {model:"star",color:16765803,s0:1.6,s1:0.3,t:6,life:7,spin:170,dy:0.0}
execute anchored eyes run particle minecraft:end_rod ^ ^-0.2 ^0.8 0.6 0.6 0.6 0.02 30
execute anchored eyes run particle minecraft:dust{color:[1.0,0.827,0.42],scale:1.0} ^ ^-0.2 ^0.8 0.4 0.4 0.4 0 12
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 1.5 2
playsound minecraft:block.respawn_anchor.charge player @a ~ ~ ~ 0.6 1.8
effect give @s minecraft:slowness 1 2 true
execute positioned ~ ~1.5 ~ run function ch:api/fx/light {t:6}
