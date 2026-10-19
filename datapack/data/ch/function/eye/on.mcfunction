# Op: become the Eye, a vast eye wrapped in darkness. You fly, cannot be hurt, and can speak to players, judge them
# with your gaze, and give or take their hearts. Open the controls with /function ch:eye/panel.
execute if score @s ch.eye matches 1.. run return run tellraw @s {text:"You already are the Eye.",color:"dark_purple"}
scoreboard players set @s ch.eye 1
execute store result storage ch:tmp ey.pid int 1 run scoreboard players get @s ch.pid
data modify storage ch:tmp ey.gm set value "survival"
execute if entity @s[gamemode=adventure] run data modify storage ch:tmp ey.gm set value "adventure"
execute if entity @s[gamemode=creative] run data modify storage ch:tmp ey.gm set value "creative"
data modify storage ch:tmp ey.eq set from entity @s equipment
function ch:eye/stash with storage ch:tmp ey
item replace entity @s armor.head with minecraft:air
item replace entity @s armor.chest with minecraft:air
item replace entity @s armor.legs with minecraft:air
item replace entity @s armor.feet with minecraft:air
gamemode creative @s
effect give @s minecraft:invisibility infinite 0 true
team join ch.eye @s
function ch:eye/summon
function ch:eye/arrive
tellraw @s [{text:"◉ You are the Eye. ",color:"dark_purple",bold:true},{text:"[Open controls]",color:"light_purple",click_event:{action:"run_command",command:"/function ch:eye/panel"}},{text:"  /function ch:eye/off to return.",color:"gray"}]
function ch:eye/panel
