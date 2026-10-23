# As the caster: if Starlight is full, spends it and makes this cast Exalted (#ce_ex 1: +50% damage, wider).
scoreboard players set #ce_ex ch.tmp 0
execute unless score @s ch.celestial.sl matches 100.. run return 0
scoreboard players set #ce_ex ch.tmp 1
scoreboard players set @s ch.celestial.sl 0
scoreboard players set @s ch.celestial.full 0
function ch:kit/celestial/fx/banner {o:"celestial",color:"#FFF2B0",in:1,stay:6,out:12,sub:"✦ EXALTED ✦",subc:"#FFD36B"}
playsound minecraft:block.beacon.power_select player @a ~ ~ ~ 1.2 1.6
playsound minecraft:item.totem.use player @s ~ ~ ~ 0.4 1.8
particle minecraft:totem_of_undying ~ ~1 ~ 0.4 0.6 0.4 0.3 30
