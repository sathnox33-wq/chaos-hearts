# Stomp: stay close too long and Golgoth plants its feet; a red ring grows under it, then the ground bursts.
scoreboard players set @s ch.v3 0
scoreboard players set @s ch.v6 16
scoreboard players set @s ch.titan.tb2 1
data merge entity @s {NoAI:1b}
execute positioned ~ ~0.06 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:16742954,s0:0.5,s1:12.0,t:16,life:18,spin:150,dy:0.0}
playsound minecraft:block.respawn_anchor.charge master @a ~ ~ ~ 1.5 0.5
playsound chaoshearts:trial_telegraph master @a ~ ~ ~ 1 0.7
function ch:trials/titan/callout {m:"Golgoth plants its feet... get away!"}
