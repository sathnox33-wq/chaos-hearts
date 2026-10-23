# The attacker is lashed by its own blow.
$function ch:api/hit {d:$(d)}
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes rotated ~ 0 run function ch:api/fx/sprite {model:"slash",color:5900810,s0:0.5,s1:2.4,t:2,life:6,spin:160,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.2 18
playsound minecraft:entity.player.attack.sweep player @a ~ ~ ~ 0.8 0.5
playsound minecraft:block.chain.break player @a ~ ~ ~ 0.8 0.6
