# As the Celestial: the Radiant Beam. Pierces every enemy on a 28-block line; Prism splits it at the first one hit.
scoreboard players set #hits ch.tmp 0
scoreboard players set #ce_n ch.tmp 0
scoreboard players set #ce_max ch.tmp 56
scoreboard players set #ce_first ch.tmp 0
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:kit/celestial/beam/march
execute store result storage ch:tmp cb.len float 0.5 run scoreboard players get #ce_n ch.tmp
execute anchored eyes positioned ^ ^-0.2 ^0.5 run function ch:kit/celestial/beam/draw with storage ch:tmp cb
execute as @e[tag=ch.celestial.bt] at @s run function ch:kit/celestial/beam/hurt
tag @e[tag=ch.celestial.bt] remove ch.celestial.bt
execute if score @s ch.b3 matches 2.. as @e[type=marker,tag=ch.celestial.pf,limit=1] at @s run function ch:kit/celestial/beam/prism
kill @e[type=marker,tag=ch.celestial.pf]
execute if score #hits ch.tmp matches 3.. run function ch:api/feat {h:"celestial",n:2}
playsound chaoshearts:celestial_beam player @a ~ ~ ~ 1.4 1
playsound minecraft:entity.guardian.attack player @a ~ ~ ~ 0.6 1.8
playsound minecraft:block.beacon.activate player @a ~ ~ ~ 0.8 2
function ch:api/fx/screen {o:"celestial",color:"#FFFFFF",in:1,stay:2,out:8}
function ch:api/fx/shake {s:1,t:4,r:4}
