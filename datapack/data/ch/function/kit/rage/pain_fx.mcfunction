# The cracked heart splits a little more with every blow: spatter, and a red flash and heartbeat on heavy hits.
particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~1.1 ~ 0.25 0.35 0.25 0.1 10
particle minecraft:dust{color:[0.6,0.0,0.02],scale:1.2} ~ ~1.1 ~ 0.3 0.4 0.3 0 8
execute if score #pd ch.tmp matches 30.. run function ch:api/fx/screen {o:"rage",color:"#8A0000",in:0,stay:2,out:8}
execute if score #pd ch.tmp matches 30.. run playsound minecraft:entity.warden.heartbeat player @s ~ ~ ~ 1 1.4
execute if score #pd ch.tmp matches 50.. anchored eyes positioned ^ ^-0.45 ^0.45 rotated ~ 90 run function ch:api/fx/sprite {model:"crack",color:14689835,s0:0.2,s1:0.9,t:3,life:10,spin:0,dy:0.0}
execute if score #pd ch.tmp matches 50.. run particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.2 ~ 0.3 0.3 0.3 0 12
