# Every two blocks of a dash: a warp ring the dasher tore through, and (Thousand Cuts) a slash that strikes again.
execute positioned ~ ~1 ~ rotated ~ ~90 run function ch:api/fx/sprite {model:"ring_soft",color:16113986,s0:1.8,s1:0.2,t:6,life:8,spin:0,dy:0.0}
particle minecraft:cloud ~ ~0.6 ~ 0.1 0.1 0.1 0.02 2
execute if score @s ch.b1 matches 5.. positioned ~ ~1 ~ run function ch:kit/speed/dash/cutmark
