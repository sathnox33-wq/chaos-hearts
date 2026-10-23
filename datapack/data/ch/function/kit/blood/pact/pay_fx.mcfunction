# The price is paid: the heart is torn and blood sprays out of the chest.
execute anchored eyes positioned ^ ^-0.45 ^0.5 rotated ~ 90 run function ch:api/fx/sprite {model:"crack",color:16723263,s0:0.3,s1:1.6,t:3,life:12,spin:0,dy:0.0}
execute anchored eyes positioned ^ ^-0.45 ^0.4 run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.2 0.2 0.2 0.35 40
particle minecraft:damage_indicator ~ ~1.2 ~ 0.3 0.3 0.3 0.1 6
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.4 ~ 0.4 0.3 0.4 0 20
function ch:api/fx/screen {o:"blood",color:"#9E0B1F",in:0,stay:4,out:12}
playsound chaoshearts:blood_pact player @a ~ ~ ~ 1.2 1
playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 1.5 0.8
playsound minecraft:entity.player.hurt player @a ~ ~ ~ 0.8 0.6
