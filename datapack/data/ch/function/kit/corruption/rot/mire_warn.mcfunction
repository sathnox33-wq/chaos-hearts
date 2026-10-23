# Down: the mire bubbles for a second before the roots come (telegraph).
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:13161514,s0:10.0,s1:2.0,t:20,life:22,spin:170,dy:0.0}
playsound minecraft:block.mud.break player @a ~ ~ ~ 1.5 0.5
playsound minecraft:entity.warden.dig player @a ~ ~ ~ 1 1.4
