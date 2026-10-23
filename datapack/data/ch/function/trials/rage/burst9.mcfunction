# Eruption ring at radius 9: fire spikes burst along it; the challenger standing on it takes 7.
function ch:api/fx/wave {color:16738847,r:9.0,t:3}
execute positioned ~9.0 ~-0.4 ~0.0 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~7.8 ~-0.4 ~4.5 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~4.5 ~-0.4 ~7.8 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~0.0 ~-0.4 ~9.0 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~-4.5 ~-0.4 ~7.8 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~-7.8 ~-0.4 ~4.5 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~-9.0 ~-0.4 ~0.0 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~-7.8 ~-0.4 ~-4.5 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~-4.5 ~-0.4 ~-7.8 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~-0.0 ~-0.4 ~-9.0 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~4.5 ~-0.4 ~-7.8 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
execute positioned ~7.8 ~-0.4 ~-4.5 run function ch:api/fx/sprite3 {model:"spike",color:14689835,a:"[0.5,0.05,0.5]",b:"[1.0,2.4,1.0]",t:2,life:10,spin:45}
function ch:api/fx/ring {p:"minecraft:flame",r:9}
tag @e[type=ravager,tag=ch.rage.boss,distance=..80,limit=1] add ch.caster
execute as @a[tag=ch.challenger,distance=7.7..10.3] run function ch:trials/rage/met_dmg
tag @e[tag=ch.caster] remove ch.caster
playsound minecraft:block.pointed_dripstone.land master @a[distance=..90] ~ ~ ~ 1.5 0.5
playsound minecraft:entity.blaze.shoot master @a[distance=..90] ~ ~ ~ 1 0.6
