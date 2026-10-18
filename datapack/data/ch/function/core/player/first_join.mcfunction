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
tellraw @s [{text:"\n❤ ",color:"#c04cff"},{text:"Chaos Hearts",color:"#c04cff",bold:true},{text:"\nWin hearts in PvP, master them, and face their Awakening Trials.\n",color:"gray"},{text:"Hold your Focus: ",color:"gray"},{text:"right-click",color:"white"},{text:", ",color:"gray"},{text:"sneak + right-click",color:"white"},{text:", ",color:"gray"},{text:"F",color:"white"},{text:" and ",color:"gray"},{text:"sneak + F",color:"white"},{text:" cast your four abilities.\n",color:"gray"},{text:"[Open the Chaos Hearts menu]",color:"light_purple",underlined:true,click_event:{action:"run_command",command:"/trigger hearts"}},{text:"  or type /trigger hearts\n",color:"dark_gray"}]
execute if score #starter ch.cfg matches 1 run function ch:heart/starter
function ch:focus/ensure
