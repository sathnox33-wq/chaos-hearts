# As a player: flashes a full-screen overlay. o is a name from tools/glyphs.json overlays.
$data modify storage ch:tmp ov set from storage ch:const overlay.$(o)
$title @s times $(in) $(stay) $(out)
title @s subtitle ""
$title @s title {storage:"ch:tmp",nbt:"ov",font:"chaoshearts:overlay",color:"$(color)"}
