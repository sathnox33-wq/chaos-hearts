# Stone Skin (phase 2+): Golgoth hardens for 8 s and takes far less damage. Dodge until it cracks.
scoreboard players set @s ch.v5 400
scoreboard players set @s ch.v4 160
effect give @s minecraft:resistance 8 2 true
function ch:trials/titan/callout {m:"Golgoth's skin turns to stone! Dodge until it cracks."}
playsound minecraft:block.anvil.place master @a ~ ~ ~ 1.5 0.5
playsound chaoshearts:titan_stoneskin master @a ~ ~ ~ 1.5 0.6
execute positioned ~ ~2.5 ~ rotated 0 0 run function ch:api/fx/sprite {model:"dome",color:8025194,s0:9.0,s1:6.0,t:5,life:12,spin:60,dy:0.0}
particle minecraft:block{block_state:"minecraft:stone"} ~ ~2.5 ~ 1.5 2 1.5 0.2 100
