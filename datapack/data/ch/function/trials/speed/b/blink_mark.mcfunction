# The tell: where Vael will appear, just behind the challenger.
kill @e[type=marker,tag=ch.speed.bspot,distance=..80]
summon minecraft:marker ~ ~ ~ {Tags:["ch.speed.bspot","ch.tmob","ch.noability"]}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16113986,s0:3.0,s1:1.0,t:6,life:7,spin:170,dy:0.0}
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~1 ~ 0.3 0.6 0.3 0 15
playsound chaoshearts:trial_telegraph master @a[distance=..40] ~ ~ ~ 0.8 1.8
