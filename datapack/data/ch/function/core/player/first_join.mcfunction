# A player we have never seen. Gives them an id, a starting heart and a Focus.
tag @s add ch.init
scoreboard players add #pid ch.g 1
scoreboard players operation @s ch.pid = #pid ch.g
scoreboard players set @s ch.active 0
scoreboard players set @s ch.leave 0
scoreboard players set @s ch.deaths 0
scoreboard players set @s ch.use 0
scoreboard players set @s ch.trial 0
scoreboard players set @s ch.eye 0
scoreboard players set @s ch.ctag 0
function ch:core/player/record_name
tellraw @s [{text:"\n❤ ",color:"#c04cff"},{text:"Chaos Hearts",color:"#c04cff",bold:true},{text:"\nWin hearts in PvP. Each one is a real heart on your health bar and carries four abilities.\n",color:"gray"},{text:"Hold Sneak",color:"white"},{text:" and tap: ",color:"gray"},{text:"Jump",color:"white"},{text:" ability 1, ",color:"gray"},{text:"Sprint",color:"white"},{text:" ability 2, ",color:"gray"},{text:"Left twice",color:"white"},{text:" ability 3, ",color:"gray"},{text:"Right twice",color:"white"},{text:" ultimate, ",color:"gray"},{text:"Back",color:"white"},{text:" shuffle hearts. Look up or down while casting for variants.\n",color:"gray"},{text:"[Open the Chaos Hearts menu]",color:"light_purple",underlined:true,click_event:{action:"run_command",command:"/trigger hearts"}},{text:"  or type /trigger hearts\n",color:"dark_gray"}]
execute if score #starter ch.cfg matches 1 run function ch:heart/starter
function ch:core/player/max_health
