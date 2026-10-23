# Rift Pull: a rift tears open between the Sovereign and its prey and drags them in for 2.5 s before it bursts.
execute as @a[tag=ch.challenger,limit=1] run function ch:core/msg/say {m:"A rift opens! Pull away from it!",c:"#D38CFF"}
playsound minecraft:block.portal.trigger hostile @a ~ ~ ~ 1.5 1.6
playsound chaoshearts:trial_telegraph hostile @a ~ ~ ~ 1 1
execute at @a[tag=ch.challenger,limit=1] facing entity @s feet rotated ~ 0 positioned ^ ^1.8 ^4 run summon marker ~ ~ ~ {Tags:["ch.void.trift","ch.tmob","ch.noability"]}
execute as @e[type=marker,tag=ch.void.trift,distance=..40] unless score @s ch.life matches 1.. run scoreboard players set @s ch.life 50
execute at @e[type=marker,tag=ch.void.trift,distance=..40] rotated 0 0 run function ch:api/fx/sprite {model:"ring",color:9059583,s0:22.0,s1:1.0,t:50,life:52,spin:170,dy:0.0}
execute at @e[type=marker,tag=ch.void.trift,distance=..40] run function ch:api/fx/orb {color:655380,s:1.6,t:20,life:52}
