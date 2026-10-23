# Bulwark: below half health the stone hardens (+4 armor, +2 toughness), and softens again above it.
execute store result score #ti_mx ch.tmp run attribute @s minecraft:max_health get
scoreboard players operation #ti_h2 ch.tmp = @s ch.health
scoreboard players operation #ti_h2 ch.tmp *= #2 ch.g
execute if score #ti_h2 ch.tmp < #ti_mx ch.tmp unless score @s ch.titan.bw matches 1 run return run function ch:kit/titan/passive/bulwark_on
execute if score #ti_h2 ch.tmp >= #ti_mx ch.tmp if score @s ch.titan.bw matches 1 run function ch:kit/titan/passive/bulwark_off
