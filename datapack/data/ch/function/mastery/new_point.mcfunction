tellraw @s [{text:"✦ ",color:"gold"},{text:"You earned a skill point. ",color:"gold",bold:true},{text:"[Open skill tree]",color:"light_purple",click_event:{action:"run_command",command:"/trigger chmenu set 30"}}]
playsound chaoshearts:skill_unlock player @s ~ ~ ~ 1 1
