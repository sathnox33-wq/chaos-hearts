# Pandemic. Level: Outbreak - a wave of plague infests every enemy within 15 blocks and Rotlings claw out of the ground.
# Up: Plague Storm - a rotting cloud gathers overhead and rains plague on your enemies for 8 s. Down: Mass Grave -
# after a 1 s windup the dead erupt beneath your enemies, rooting and tearing them, and rise as Rotlings.
scoreboard players operation #cvar ch.tmp = #var ch.tmp
scoreboard players set #cln ch.tmp 3
execute if score @s ch.b2 matches 4.. run scoreboard players set #cln ch.tmp 5
scoreboard players set #cll ch.tmp 300
execute if score @s ch.b2 matches 5.. run scoreboard players set #cll ch.tmp 450
function ch:kit/corruption/inf/setup
playsound chaoshearts:corruption_pandemic player @a ~ ~ ~ 2 1
playsound minecraft:entity.wither.spawn player @a ~ ~ ~ 0.5 1.4
playsound minecraft:entity.zombie.infect player @a ~ ~ ~ 1.5 0.5
function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:2,stay:10,out:20}
execute if score #cvar ch.tmp matches 0 run title @s subtitle {text:"☣ Pandemic",color:"#7BD13A",bold:true}
execute if score #cvar ch.tmp matches 1 run title @s subtitle {text:"☣ Plague Storm",color:"#7BD13A",bold:true}
execute if score #cvar ch.tmp matches 2 run title @s subtitle {text:"☣ Mass Grave",color:"#7BD13A",bold:true}
execute if score #cvar ch.tmp matches 0 run function ch:kit/corruption/pan/outbreak
execute if score #cvar ch.tmp matches 1 run function ch:kit/corruption/pan/storm
execute if score #cvar ch.tmp matches 2 run function ch:kit/corruption/pan/grave
execute unless score #cvar ch.tmp matches 2 run function ch:kit/corruption/pan/ring
return 1
