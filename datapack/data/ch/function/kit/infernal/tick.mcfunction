# Infernal per-player tick: Fireproof, the Heat meter, Overheat glow, Inferno Avatar, Supernova and the aura.
execute if score #t20 ch.g matches 0 run effect give @s minecraft:fire_resistance 15 0 true
execute if score #t20 ch.g matches 0 if score @s ch.infernal.heat matches 1..99 run scoreboard players remove @s ch.infernal.heat 2
execute if score @s ch.infernal.heat matches ..-1 run scoreboard players set @s ch.infernal.heat 0
scoreboard players operation @s ch.meter = @s ch.infernal.heat
execute if score @s ch.infernal.heat matches 100.. run particle minecraft:small_flame ~ ~1.1 ~ 0.3 0.5 0.3 0.02 1
execute if score @s ch.infernal.ovh matches 1.. run scoreboard players remove @s ch.infernal.ovh 1
execute if score @s ch.infernal.ovh matches 1.. run particle minecraft:dust{color:[1.0,0.95,0.79],scale:1.2} ~ ~1 ~ 0.35 0.6 0.35 0 2
execute if score @s ch.infernal.av matches 1.. run function ch:kit/infernal/avatar/tick
execute if score @s ch.infernal.nova matches 1.. run function ch:kit/infernal/avatar/nova_tick
execute if score @s ch.lvl matches 90.. run function ch:kit/infernal/aura
