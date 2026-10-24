# Extra layers for fx/beam: a twisting dust braid and themed core along the beam, rings around it, a burst at its end.
execute if score #vb ch.g matches 12.. run return 0
scoreboard players add #vb ch.g 1
$function ch:vfx/col {color:$(color)}
$data modify storage ch:vfx cur.lf set value $(len)
execute store result score #bl ch.tmp run data get storage ch:vfx cur.lf
execute if score #bl ch.tmp matches ..5 run function ch:vfx/up/beam_l {l:4}
execute if score #bl ch.tmp matches 6..9 run function ch:vfx/up/beam_l {l:8}
execute if score #bl ch.tmp matches 10..13 run function ch:vfx/up/beam_l {l:12}
execute if score #bl ch.tmp matches 14..19 run function ch:vfx/up/beam_l {l:16}
execute if score #bl ch.tmp matches 20..27 run function ch:vfx/up/beam_l {l:24}
execute if score #bl ch.tmp matches 28.. run function ch:vfx/up/beam_l {l:32}
$execute positioned ^ ^ ^$(len) run function ch:vfx/sh {s:"burst16",k:"a",v:0.3}
