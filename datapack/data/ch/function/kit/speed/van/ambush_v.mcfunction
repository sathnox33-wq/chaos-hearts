# As the Shade Ambush victim.
function ch:api/stun {t:20}
scoreboard players set @s ch.speed.boom 10
scoreboard players operation @s ch.speed.bd = #d ch.speed.g
scoreboard players operation @s ch.speed.bo = #pid ch.speed.g
scoreboard players set #boom ch.speed.g 1
execute rotated as @a[tag=ch.caster,limit=1] run function ch:api/fx/slash {color:2741234,s:3.0,roll:45,t:3}
execute rotated as @a[tag=ch.caster,limit=1] run function ch:api/fx/slash {color:16777215,s:3.0,roll:-45,t:3}
execute positioned ~ ~0.1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:2741234,s0:0.3,s1:2.0,t:4,life:20,spin:120,dy:0.0}
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.6 0.3 0.1 30
execute if entity @s[type=player] run function ch:api/fx/screen {o:"vignette",color:"#29D3F2",in:0,stay:10,out:10}
function ch:api/fx/shake {s:2,t:8,r:1}
