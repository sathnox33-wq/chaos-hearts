# Rift Orb. Level: a slow orb of nothing drifts forward dragging enemies in. Up: it shoots ahead, anchors and lifts
# everyone into the air before slamming them down. Down: a hidden rift mine that arms and violently implodes.
scoreboard players operation #vvar ch.tmp = #var ch.tmp
execute if score #vvar ch.tmp matches 0..1 anchored eyes positioned ^ ^ ^1.5 run function ch:kit/void/orb/spawn
execute if score #vvar ch.tmp matches 2 rotated ~ 0 positioned ^ ^0.7 ^2.5 run function ch:kit/void/orb/spawn
playsound chaoshearts:void_orb player @a ~ ~ ~ 1 1
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 0.6 1.7
execute anchored eyes positioned ^ ^ ^1.2 rotated ~ ~90 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:0.3,s1:2.4,t:4,life:7,spin:170,dy:0.0}
execute anchored eyes positioned ^ ^ ^1.2 rotated ~ ~90 run function ch:api/fx/sprite {model:"swirl",color:655380,s0:1.6,s1:0.2,t:5,life:7,spin:-170,dy:0.0}
particle minecraft:portal ^ ^1.5 ^1.2 0.3 0.3 0.3 1 30
return 1
