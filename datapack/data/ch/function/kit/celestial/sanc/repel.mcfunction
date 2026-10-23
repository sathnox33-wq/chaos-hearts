# The Aegis repels this enemy with a crack of light.
execute positioned as @e[type=marker,tag=ch.celestial.sanc,sort=nearest,limit=1] run function ch:api/push {s:0.8,y:0.35}
particle minecraft:end_rod ~ ~1 ~ 0.3 0.5 0.3 0.1 10
playsound minecraft:block.amethyst_block.hit player @a ~ ~ ~ 1 1.6
execute if entity @s[type=player] run function ch:api/fx/screen {o:"celestial",color:"#BFE6FF",in:1,stay:1,out:6}
