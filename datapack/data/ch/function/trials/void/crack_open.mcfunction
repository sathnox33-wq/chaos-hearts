# Later: the crack opens - a zone of nothing that burns for 4 damage a second for 5 seconds.
summon marker ~ ~ ~ {Tags:["ch.void.tzone","ch.tmob","ch.noability"]}
scoreboard players set @e[type=marker,tag=ch.void.tzone,distance=..0.1,limit=1] ch.life 100
execute rotated 0 0 run function ch:api/fx/sprite {model:"crack",color:655380,s0:6.0,s1:6.2,t:100,life:100,spin:0,dy:0.0}
execute rotated 0 0 run function ch:api/fx/sprite {model:"hex",color:9059583,s0:6.0,s1:5.0,t:100,life:100,spin:170,dy:0.0}
playsound minecraft:entity.generic.explode hostile @a ~ ~ ~ 0.8 0.6
