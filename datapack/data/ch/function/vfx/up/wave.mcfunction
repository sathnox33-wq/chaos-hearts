# Extra layers for fx/wave: an expanding ring of dust that keeps pace with the shockwave, ground streaks of the
# heart's particle, and a themed rim with rising embers when it reaches full size.
execute if score #vb ch.g matches 12.. run return 0
scoreboard players add #vb ch.g 1
$function ch:vfx/col {color:$(color)}
$data modify storage ch:vfx cur.rf set value $(r)
execute store result storage ch:vfx cur.rr int 1 run data get storage ch:vfx cur.rf 100
function ch:vfx/sh {s:"streak24",k:"a",v:0.45}
execute positioned ~ ~0.1 ~ run function ch:vfx/sh {s:"streak16",k:"c",v:0.25}
$execute rotated 0 0 run function ch:vfx/play {f:"ch:vfx/up/wave_f",n:$(t),spin:7,dy:0,fw:0}
function ch:vfx/keep_cur
