# As the new host (owner tagged ch.caster): plants an infection from #cfuse #cgen #crad #cdmg and the flags.
summon marker ~ ~ ~ {Tags:["ch.corruption.inf","ch.corruption.inew","ch.noability"]}
execute as @e[type=marker,tag=ch.corruption.inew,limit=1] run function ch:kit/corruption/inf/init
tag @s add ch.corruption.host
scoreboard players operation @s ch.corruption.hid = #chid ch.tmp
playsound minecraft:entity.silverfish.ambient player @a ~ ~ ~ 1 0.6
particle minecraft:dust{color:[0.643,1.0,0.31],scale:1.4} ~ ~1 ~ 0.3 0.5 0.3 0 20
execute positioned ~ ~2.4 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"skull",color:10813263,s0:1.6,s1:0.6,t:4,life:12,spin:0,dy:0.0}
execute if entity @s[type=player] unless entity @s[tag=ch.caster] run function ch:api/fx/screen {o:"corruption",color:"#7BD13A",in:1,stay:16,out:16}
execute if entity @s[type=player] unless entity @s[tag=ch.caster] run title @s subtitle {text:"You have been infested",color:"#7BD13A",bold:true}
