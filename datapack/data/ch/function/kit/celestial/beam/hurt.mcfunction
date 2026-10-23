# Pierced by Radiant light: damage, Glowing, Searing Light's blindness on players, Starlight for the Celestial.
execute store result score #ce_ok ch.tmp run function ch:kit/celestial/hit
execute unless score #ce_ok ch.tmp matches 1.. run return 0
effect give @s minecraft:glowing 6 0 true
execute if entity @s[type=player] if entity @a[tag=ch.caster,scores={ch.b3=3..},limit=1] run function ch:api/cc {effect:"minecraft:blindness",sec:1,amp:0}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"flash",color:"#FFFFFF",in:1,stay:2,out:10}
particle minecraft:end_rod ~ ~1 ~ 0.3 0.5 0.3 0.1 10
particle minecraft:firework ~ ~1 ~ 0.2 0.4 0.2 0.1 6
scoreboard players add @a[tag=ch.caster,limit=1] ch.celestial.sl 4
