$scoreboard players set #x ch.tmp $(xp)
$function ch:mastery/add {h:"$(h)"}
$tellraw @s [{text:"✦ Feat complete: ",color:"gold"},{storage:"ch:tmp",nbt:"f.name",color:"$(color)",bold:true},{text:" - ",color:"dark_gray"},{storage:"ch:tmp",nbt:"f.desc",color:"gray"},{text:"  +$(xp) mastery XP",color:"yellow"}]
playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 0.6 1.2
