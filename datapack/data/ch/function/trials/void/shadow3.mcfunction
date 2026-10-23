# As the boss behind its prey: darkness falls, the ring closes, then it strikes.
effect clear @s minecraft:invisibility
function ch:trials/void/spawn_fx
playsound minecraft:entity.enderman.scream hostile @a ~ ~ ~ 1.5 0.7
effect give @a[tag=ch.challenger,distance=..20] minecraft:darkness 3 0 true
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13864191,s0:0.5,s1:6.0,t:14,life:16,spin:170,dy:0.0}
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:1310763,s0:6.0,s1:6.0,t:14,life:16,spin:-90,dy:0.0}
function ch:api/later {t:14,then:"ch:trials/void/shadow_hit"}
