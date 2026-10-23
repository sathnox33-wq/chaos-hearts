# The Chain bolt: Voltaris gathers a bolt for 18 ticks. Break line of sight behind a pillar, or take it.
execute if score @s ch.v2 matches 1 run tellraw @a[tag=ch.challenger] {text:"Voltaris gathers a bolt... break line of sight!",color:"#E8F6FF",italic:true}
execute if score @s ch.v2 matches 1 positioned ~ ~3.6 ~ run function ch:api/fx/sprite {model:"orb",color:15267583,s0:0.2,s1:2.4,t:18,life:19,spin:170,dy:0.0}
execute if score @s ch.v2 matches 1 run playsound minecraft:block.beacon.power_select master @a[distance=..60] ~ ~ ~ 1.5 2
execute if score @s ch.v2 matches 1..18 if score #t2 ch.storm.g matches 0 run particle minecraft:electric_spark ~ ~3.6 ~ 0.8 0.8 0.8 0 10
execute if score @s ch.v2 matches 10 run playsound minecraft:block.respawn_anchor.charge master @a[distance=..60] ~ ~ ~ 1.5 1.6
execute if score @s ch.v2 matches 18 run function ch:trials/storm/b/chain_fire
execute if score @s ch.v2 matches 30.. run function ch:trials/storm/b/end
