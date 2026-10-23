# Supercell breaks: five bolts at once, everything within 9 blocks struck (hardest at the centre) and stunned.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
function ch:kit/storm/fn/bolt
execute rotated 0 0 positioned ^ ^ ^5 run function ch:kit/storm/fn/bolt
execute rotated 72 0 positioned ^ ^ ^5 run function ch:kit/storm/fn/bolt
execute rotated 144 0 positioned ^ ^ ^5 run function ch:kit/storm/fn/bolt
execute rotated 216 0 positioned ^ ^ ^5 run function ch:kit/storm/fn/bolt
execute rotated 288 0 positioned ^ ^ ^5 run function ch:kit/storm/fn/bolt
function ch:api/fx/wave {color:16777215,r:9.0,t:6}
function ch:api/fx/sprite {model:"orb",color:15267583,s0:1.0,s1:9.0,t:3,life:7,spin:0,dy:0.0}
particle minecraft:explosion_emitter ~ ~1 ~ 2 0.5 2 0 4
playsound chaoshearts:storm_thunder player @a ~ ~ ~ 2 1
playsound minecraft:entity.lightning_bolt.thunder player @a ~ ~ ~ 2 0.6
scoreboard players set #d ch.storm.g 70
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=4..9] at @s run function ch:kit/storm/tempest/super_one
scoreboard players set #d ch.storm.g 120
execute as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4] at @s run function ch:kit/storm/tempest/super_one
execute as @a[distance=..18] run function ch:api/fx/screen {o:"flash",color:"#E8F6FF",in:0,stay:3,out:16}
function ch:api/fx/shake {s:3,t:16,r:18}
