# As the ambushed enemy: two black slashes cross through it.
tag @s remove ch.void.ambt
scoreboard players operation #vd ch.tmp = @s ch.void.amb
execute store success score #ver ch.tmp if entity @a[tag=ch.caster,scores={ch.b3=4..},limit=1]
function ch:kit/void/hurt
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 1 0.5
playsound chaoshearts:void_step player @a ~ ~ ~ 0.6 1.7
particle minecraft:sweep_attack ~ ~1.1 ~ 0.3 0.3 0.3 0 3
particle minecraft:squid_ink ~ ~1.1 ~ 0.2 0.4 0.2 0.08 10
execute positioned ~ ~1.1 ~ rotated ~ 90 run function ch:api/fx/sprite3 {model:"slash",color:655380,a:"[0.4,0.4,0.4]",b:"[2.6,2.6,2.6]",t:3,life:8,spin:90}
execute positioned ~ ~1.1 ~ rotated ~90 90 run function ch:api/fx/sprite3 {model:"slash",color:9059583,a:"[0.4,0.4,0.4]",b:"[2.4,2.4,2.4]",t:3,life:8,spin:-90}
