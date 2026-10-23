# Crimson Pact: pay 2 hearts (1 with Cheap Price; you need more than that plus half a heart). Level: Pact of Power,
# Strength II for 8 s (+Speed II and Haste II with Red Haste). Up: Blood Ward, 4 hearts of absorption for 8 s and
# everyone who strikes you is lashed and bleeds. Down: Sanguine Nova, your heart swells for 10 ticks (a ring warns
# everyone) and bursts: 5 damage and a bleed around you, and you drink from every wound.
scoreboard players set #cost ch.tmp 40
execute if score @s ch.b3 matches 1.. run scoreboard players set #cost ch.tmp 20
execute store result score #hp ch.tmp run data get entity @s Health 10
scoreboard players operation #need ch.tmp = #cost ch.tmp
scoreboard players add #need ch.tmp 10
execute if score #hp ch.tmp <= #need ch.tmp run return run function ch:kit/blood/pact/weak
execute if score #cost ch.tmp matches 40 run damage @s 4 ch:bleed
execute if score #cost ch.tmp matches 20 run damage @s 2 ch:bleed
function ch:kit/blood/pact/pay_fx
scoreboard players set @s ch.blood.pact 160
execute if score @s ch.b3 matches 2.. run scoreboard players set @s ch.blood.pact 224
scoreboard players set @s ch.blood.pv 0
execute if score #var ch.tmp matches 1 run return run function ch:kit/blood/pact/ward
execute if score #var ch.tmp matches 2 run return run function ch:kit/blood/pact/nova
return run function ch:kit/blood/pact/power
