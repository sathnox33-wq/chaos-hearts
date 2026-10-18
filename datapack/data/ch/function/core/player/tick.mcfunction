scoreboard players operation @s ch.seen = #now ch.g
execute if score @s ch.deaths matches 1.. run function ch:core/player/died
execute if score @s ch.cd1 matches 1.. run function ch:core/player/cooldown {s:1}
execute if score @s ch.cd2 matches 1.. run function ch:core/player/cooldown {s:2}
execute if score @s ch.cd3 matches 1.. run function ch:core/player/cooldown {s:3}
execute if score @s ch.cd4 matches 1.. run function ch:core/player/cooldown {s:4}
execute if score @s ch.swapcd matches 1.. run scoreboard players remove @s ch.swapcd 1
execute if score @s ch.ccimm matches 1.. run scoreboard players remove @s ch.ccimm 1
execute if score @s ch.tgtt matches 1.. run scoreboard players remove @s ch.tgtt 1
execute if score @s ch.use matches 1.. run function ch:core/input/use
execute if items entity @s weapon.offhand carrot_on_a_stick[custom_data~{ch:{focus:1}}] run function ch:core/input/swap
execute if score @s hearts matches 1.. run function ch:menu/open
execute if score @s cast matches 1.. run function ch:core/input/cast_trigger
execute if score @s chmenu matches 1.. run function ch:menu/action
scoreboard players enable @s hearts
scoreboard players enable @s cast
scoreboard players enable @s chmenu
execute if score #t20 ch.g matches 0 if score @s ch.ctag > #now ch.g run function ch:core/player/combat_check
scoreboard players add @s ch.hud 1
execute if score @s ch.hud matches 5.. run function ch:core/player/hud
