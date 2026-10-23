# Recoil: a slash sigil ticks where you stood, then detonates. Telegraphed so it can be dodged.
scoreboard players set #v1 ch.speed.g 60
execute if score @s ch.b1 matches 1.. run scoreboard players set #v1 ch.speed.g 75
function ch:api/later {t:16,then:"ch:kit/speed/dash/trap"}
execute as @e[type=marker,tag=ch.lnew,limit=1,sort=nearest] run function ch:kit/speed/fn/cfg
execute positioned ~ ~0.08 ~ rotated 0 0 run function ch:api/fx/sprite {model:"rune",color:16113986,s0:0.2,s1:3.2,t:6,life:18,spin:170,dy:0.0}
execute positioned ~ ~0.1 ~ rotated 45 0 run function ch:api/fx/sprite {model:"hex",color:2741234,s0:3.4,s1:2.6,t:16,life:18,spin:-120,dy:0.0}
particle minecraft:dust{color:[0.96,0.88,0.26],scale:1.2} ~ ~0.3 ~ 1.4 0.05 1.4 0 30
playsound chaoshearts:trial_telegraph player @a ~ ~ ~ 0.7 1.6
playsound minecraft:block.note_block.hat player @a ~ ~ ~ 1 0.8
