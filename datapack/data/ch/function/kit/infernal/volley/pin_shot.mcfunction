# As the caster: throws pinwheel ember #i_k flat outward at yaw #i_yaw + #i_k x #i_st.
execute unless score @s ch.active matches 3 run return 0
function ch:kit/infernal/pal
scoreboard players set #i_kind ch.tmp 4
scoreboard players set #i_dmg ch.tmp 35
execute if score @s ch.b1 matches 1.. run function ch:kit/infernal/mul_dmg
function ch:kit/infernal/volley/launch
scoreboard players operation #i_a ch.tmp = #i_k ch.tmp
scoreboard players operation #i_a ch.tmp *= #i_st ch.tmp
scoreboard players operation #i_a ch.tmp += #i_yaw ch.tmp
execute as @e[type=item_display,tag=ch.infernal.np,limit=1] store result entity @s Rotation[0] float 1 run scoreboard players get #i_a ch.tmp
execute as @e[type=item_display,tag=ch.infernal.np,limit=1] run data modify entity @s Rotation[1] set value 0.0f
scoreboard players set @e[type=item_display,tag=ch.infernal.np,limit=1] ch.life 14
function ch:kit/infernal/volley/done
playsound minecraft:item.firecharge.use player @a ~ ~ ~ 0.4 1.5
