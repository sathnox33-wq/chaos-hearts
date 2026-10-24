# Extra layers for fx/slash: a three-line crescent of dust along the swing and a spray of the heart's particle.
execute if score #vb ch.g matches 12.. run return 0
scoreboard players add #vb ch.g 1
$function ch:vfx/col {color:$(color)}
$data modify storage ch:vfx cur.sf set value $(s)
execute store result score #os ch.tmp run data get storage ch:vfx cur.sf 10
execute if score #os ch.tmp matches ..24 anchored eyes positioned ^ ^-0.2 ^0.4 run function ch:vfx/sh {s:"arc2",k:"d",v:0}
execute if score #os ch.tmp matches 25..34 anchored eyes positioned ^ ^-0.2 ^0.4 run function ch:vfx/sh {s:"arc3",k:"d",v:0}
execute if score #os ch.tmp matches 35..49 anchored eyes positioned ^ ^-0.2 ^0.4 run function ch:vfx/sh {s:"arc4",k:"d",v:0}
execute if score #os ch.tmp matches 50.. anchored eyes positioned ^ ^-0.2 ^0.4 run function ch:vfx/sh {s:"arc6",k:"d",v:0}
execute anchored eyes positioned ^ ^-0.2 ^1.6 run function ch:vfx/sh {s:"burst16",k:"a",v:0.25}
