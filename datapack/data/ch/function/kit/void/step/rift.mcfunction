# Awakened (Event Horizon): a rift stays open where you stood for 5 seconds; casting Void Step again returns you.
summon marker ~ ~ ~ {Tags:["ch.void.rift","ch.void.rnew","ch.noability"]}
scoreboard players operation @e[type=marker,tag=ch.void.rnew,limit=1] ch.owner = @s ch.pid
scoreboard players set @e[type=marker,tag=ch.void.rnew,limit=1] ch.life 100
tag @e[type=marker,tag=ch.void.rnew] remove ch.void.rnew
execute positioned ~ ~1 ~ rotated ~ 90 run function ch:api/fx/sprite {model:"rune",color:9059583,s0:0.2,s1:2.0,t:6,life:100,spin:0,dy:0.0}
execute positioned ~ ~1 ~ rotated ~ 0 run function ch:api/fx/sprite3 {model:"crack",color:13864191,a:"[0.1,0.1,0.1]",b:"[0.6,2.4,0.6]",t:6,life:100,spin:0}
playsound chaoshearts:void_rift player @a ~ ~ ~ 1 1
function ch:api/cooldown {slot:1,t:1}
function ch:core/msg/say {m:"A rift holds open behind you. Step again to return.",c:"#D38CFF"}
