# The Executioner's rend lands.
$function ch:api/hit {d:$(d)}
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes rotated ~ 0 run function ch:api/fx/sprite {model:"slash",color:14689835,s0:0.6,s1:2.2,t:2,life:6,spin:120,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.1 16
playsound minecraft:entity.player.attack.crit player @a ~ ~ ~ 1 0.5
playsound minecraft:item.trident.hit player @a ~ ~ ~ 0.6 0.6
