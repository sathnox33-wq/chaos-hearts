# Hemorrhage (passive 2): a critical hit opens the target's veins for 4 seconds.
scoreboard players set #bt ch.tmp 80
scoreboard players set #bm ch.tmp 0
function ch:kit/blood/bleed/apply
particle minecraft:dust{color:[1.0,0.18,0.25],scale:1.5} ~ ~1 ~ 0.3 0.4 0.3 0 15
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1 ~ 0.3 0.4 0.3 0.3 25
execute positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes rotated ~ 0 run function ch:api/fx/sprite {model:"slash",color:16723263,s0:0.5,s1:1.8,t:2,life:6,spin:150,dy:0.0}
playsound minecraft:block.honey_block.break player @a ~ ~ ~ 0.8 0.6
playsound minecraft:entity.player.attack.crit player @a ~ ~ ~ 0.8 0.6
