# First link: a burning ring and a slash.
execute positioned ~ ~0.1 ~ run function ch:api/fx/wave {color:16738847,r:2.5,t:5}
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes rotated ~ 0 run function ch:api/fx/sprite {model:"slash",color:16738847,s0:0.6,s1:2.4,t:2,life:6,spin:140,dy:0.0}
particle minecraft:sweep_attack ~ ~1 ~ 0.6 0.3 0.6 0 3
particle minecraft:crit ~ ~1 ~ 0.4 0.4 0.4 0.5 18
playsound minecraft:entity.player.attack.crit player @a ~ ~ ~ 1 0.7
playsound minecraft:block.anvil.land player @a ~ ~ ~ 0.25 1.4
