# Singularity. Level: a black hole opens where you look, drags everything in for 6 s, then collapses.
# Up: it crowns you, hovering above your head and following you. Down: the void folds in at once - a 1.5 s windup,
# then everything within 12 blocks is yanked to you and crushed.
scoreboard players operation #vvar ch.tmp = #var ch.tmp
scoreboard players set #vmini ch.tmp 0
execute if score #vvar ch.tmp matches 0 run function ch:kit/void/sing/aim
execute if score #vvar ch.tmp matches 1 positioned ~ ~3.5 ~ run function ch:kit/void/sing/spawn
execute if score #vvar ch.tmp matches 2 positioned ~ ~1 ~ run function ch:kit/void/sing/spawn
execute if score #vvar ch.tmp matches 1 run effect give @s minecraft:resistance 6 0 true
playsound chaoshearts:void_singularity player @a ~ ~ ~ 2 0.7
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 1.5 0.5
function ch:api/fx/screen {o:"void",color:"#14002B",in:2,stay:10,out:20}
execute if score #vvar ch.tmp matches 0 run title @s subtitle {text:"The void opens",color:"#8A3CFF",bold:true}
execute if score #vvar ch.tmp matches 1 run title @s subtitle {text:"Crown of Nothing",color:"#8A3CFF",bold:true}
execute if score #vvar ch.tmp matches 2 run title @s subtitle {text:"Everything falls inward",color:"#8A3CFF",bold:true}
function ch:api/fx/shake {s:1,t:10,r:16}
return 1
