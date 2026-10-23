# Radiance (every 4 s): allies within 8 blocks are healed; Guardian Angel doubles it and includes you.
execute as @a[tag=!ch.caster,distance=0.01..8,gamemode=!spectator] unless score @s ch.opp = #ce_pid ch.tmp at @s run function ch:kit/celestial/passive/bless
execute if score @s ch.b2 matches 4.. run function ch:kit/celestial/passive/bless_self
execute positioned ~ ~0.1 ~ run function ch:api/fx/ring {p:"minecraft:dust{color:[1.0,0.827,0.42],scale:0.9}",r:2}
playsound minecraft:block.amethyst_block.chime player @a ~ ~ ~ 0.6 1.6
