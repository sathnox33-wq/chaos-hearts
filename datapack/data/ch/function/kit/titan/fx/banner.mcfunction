# As a player: a Titan overlay flash with a bold subtitle under it.
$function ch:api/fx/screen {o:"$(o)",color:"$(color)",in:$(in),stay:$(stay),out:$(out)}
$title @s subtitle {text:"$(sub)",color:"$(subc)",bold:true}
$title @s title {storage:"ch:tmp",nbt:"ov",font:"chaoshearts:overlay",color:"$(color)"}
