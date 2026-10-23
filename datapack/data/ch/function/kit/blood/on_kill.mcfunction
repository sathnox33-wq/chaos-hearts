# Blood kills: Exsanguinate and Hemorrhagic Burst for bleeding victims, Blood Price and Martyr for players.
execute as @e[type=!#ch:ignore,distance=..32,scores={ch.blood.bleed=1..},nbt={Health:0.0f},limit=4] at @s run function ch:kit/blood/bleed_kill
execute if entity @a[distance=0.01..48,nbt={Health:0.0f},limit=1] run function ch:kit/blood/player_kill
