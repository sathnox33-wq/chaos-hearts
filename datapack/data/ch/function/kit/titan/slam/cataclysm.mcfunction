# Tremor is spent: this Ground Slam becomes a Cataclysm (bigger, longer, +50% damage, and it stuns).
scoreboard players set #ti_cat ch.tmp 1
scoreboard players set @s ch.titan.trem 0
scoreboard players set @s ch.titan.full 0
function ch:kit/titan/fx/banner {o:"titan",color:"#FF7A2A",in:1,stay:8,out:14,sub:"⚠ CATACLYSM ⚠",subc:"#FF7A2A"}
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 1.4 0.5
playsound minecraft:block.respawn_anchor.deplete player @a ~ ~ ~ 1 0.5
particle minecraft:lava ~ ~0.5 ~ 0.8 0.2 0.8 0 20
particle minecraft:flame ~ ~0.2 ~ 1.2 0.1 1.2 0.05 30
