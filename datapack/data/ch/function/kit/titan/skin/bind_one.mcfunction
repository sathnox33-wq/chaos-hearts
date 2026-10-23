# Stone closes over this target's legs: a little damage and 2 s rooted.
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/stun {t:40}
function ch:kit/titan/fx/ground
execute align y run function ch:kit/titan/skin/grip with storage ch:tmp tg
particle minecraft:block_crumble{block_state:"minecraft:stone"} ~ ~0.3 ~ 0.3 0.2 0.3 0 20
playsound minecraft:block.stone.place player @a ~ ~ ~ 1 0.6
execute if entity @s[type=player] run function ch:api/fx/screen {o:"titan",color:"#7A746A",in:1,stay:20,out:10}
