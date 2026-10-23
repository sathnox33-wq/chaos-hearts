# Blood Oath (War Cry, looking down): you tear your own heart open. Lose 1.5 hearts (and gain the Fury that pain
# brings), then 40 Fury and Strength; at full Fury, Strength II. Needs more than 3 hearts.
execute store result score #hp ch.tmp run data get entity @s Health 10
execute if score #hp ch.tmp matches ..60 run return run function ch:kit/rage/cry/oath_fail
damage @s 3 minecraft:magic
scoreboard players set #fa ch.tmp 40
function ch:kit/rage/fury/add
execute if score @s ch.rage.fury matches ..99 run effect give @s minecraft:strength 6 0
execute if score @s ch.rage.fury matches 100.. run effect give @s minecraft:strength 6 1
execute if score @s ch.b2 matches 4.. run effect give @s minecraft:resistance 5 0
execute anchored eyes positioned ^ ^-0.45 ^0.5 rotated ~ 90 run function ch:api/fx/sprite {model:"crack",color:14689835,s0:0.3,s1:1.8,t:3,life:14,spin:0,dy:0.0}
execute anchored eyes positioned ^ ^-0.45 ^0.4 run function ch:api/fx/orb {color:3801088,s:1.5,t:3,life:8}
execute anchored eyes positioned ^ ^-0.45 ^0.4 run particle minecraft:block{block_state:"minecraft:redstone_block"} ~ ~ ~ 0.2 0.2 0.2 0.3 40
particle minecraft:falling_dust{block_state:"minecraft:redstone_block"} ~ ~1.3 ~ 0.4 0.3 0.4 0 30
particle minecraft:damage_indicator ~ ~1.2 ~ 0.3 0.3 0.3 0.1 6
function ch:api/fx/wave {color:5900810,r:3.0,t:6}
function ch:api/fx/screen {o:"blood",color:"#8A0000",in:0,stay:5,out:14}
function ch:api/fx/text {text:"BLOOD OATH",color:"#C01020"}
playsound minecraft:entity.warden.heartbeat player @a ~ ~ ~ 1.6 0.7
playsound minecraft:entity.player.hurt player @a ~ ~ ~ 1 0.6
playsound chaoshearts:rage_warcry player @a ~ ~ ~ 0.8 0.6
return 1
