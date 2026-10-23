# Level Rage Leap: a long arc; with forward held, a longer and lower one.
scoreboard players set @s ch.rage.lv 0
scoreboard players set @s ch.rage.leap 60
function ch:kit/rage/leap/start
execute if score #mov ch.tmp matches 1 rotated ~ -26 run function ch:api/leap {n:3}
execute unless score #mov ch.tmp matches 1 rotated ~ -40 run function ch:api/leap {n:2}
playsound minecraft:entity.ravager.roar player @a ~ ~ ~ 0.5 1.5
execute rotated ~ 0 positioned ^ ^0.3 ^-0.6 rotated ~ 90 run function ch:api/fx/sprite {model:"ring_soft",color:16738847,s0:0.5,s1:2.5,t:4,life:7,spin:60,dy:-1.0}
