title @s times 5 50 15
$title @s subtitle {text:"$(title) Heart",color:"$(color)"}
$title @s title {text:"❤",color:"$(color)"}
playsound chaoshearts:heart_acquire player @a ~ ~ ~ 1 1
playsound minecraft:item.totem.use player @s ~ ~ ~ 0.5 1.5
$particle dust{color:$(rgbf),scale:1.5} ~ ~1 ~ 0.6 0.9 0.6 0 60
$tellraw @s [{text:"❤ ",color:"$(color)"},{text:"The $(title) Heart is yours. ",color:"$(color)",bold:true},{text:"[menu]",color:"light_purple",click_event:{action:"run_command",command:"/trigger hearts"}}]
