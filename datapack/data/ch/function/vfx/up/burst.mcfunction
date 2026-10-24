# Extra layer for fx/burst: a clean spherical blast of the same particle.
execute if score #vb ch.g matches 16.. run return 0
scoreboard players add #vb ch.g 1
$execute positioned ~ ~1 ~ run function ch:gen/vfx/burst32 {p:'$(p)',v:0.2}
