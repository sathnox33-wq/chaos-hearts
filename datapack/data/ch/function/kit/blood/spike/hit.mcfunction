# Blood Spike hits (projectile here, targets tagged ch.target): 6 damage (10 as a Lance), a 3 s bleed, and you drink 2.
scoreboard players set #sd ch.tmp 60
execute if entity @s[tag=ch.blood.lance] run scoreboard players set #sd ch.tmp 100
scoreboard players set #bt ch.tmp 60
execute if entity @s[tag=ch.blood.lance] run scoreboard players set #bt ch.tmp 120
scoreboard players set #bm ch.tmp 0
execute as @e[tag=ch.target] at @s run function ch:kit/blood/spike/wound
execute positioned ~ ~ ~ rotated as @s run function ch:api/fx/sprite {model:"crack",color:10357535,s0:0.3,s1:1.6,t:2,life:8,spin:0,dy:0.0}
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.3 0.3 0.3 0.25 30
playsound minecraft:item.trident.hit player @a ~ ~ ~ 1 0.6
playsound minecraft:entity.slime.squish player @a ~ ~ ~ 0.8 0.6
