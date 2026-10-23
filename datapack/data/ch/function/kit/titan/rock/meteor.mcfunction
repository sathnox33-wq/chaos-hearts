# The lobbed boulder crashes onto the mark: a wide blast (4.5 blocks, 6.3 with Bigger Rock), 10 damage.
execute unless entity @a[tag=ch.caster,limit=1] run return 0
data modify storage ch:tmp tg.b set from entity @s data.b
data modify storage ch:tmp tg.sz set value "b"
scoreboard players set #ti_d ch.tmp 100
execute if entity @a[tag=ch.caster,scores={ch.b3=1..},limit=1] run scoreboard players set #ti_d ch.tmp 130
function ch:kit/titan/rock/blast_fx with storage ch:tmp tg
scoreboard players set #ti_big ch.tmp 1
function ch:kit/titan/fx/ring8
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1
function ch:api/fx/wave {color:16742954,r:6.5,t:8}
function ch:api/fx/shake {s:3,t:10,r:14}
scoreboard players set #hits ch.tmp 0
execute unless entity @a[tag=ch.caster,scores={ch.b3=2..},limit=1] positioned ~ ~0.5 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.5] run function ch:kit/titan/rock/blast_hit
execute if entity @a[tag=ch.caster,scores={ch.b3=2..},limit=1] positioned ~ ~0.5 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..6.3] run function ch:kit/titan/rock/blast_hit
execute if score #hits ch.tmp matches 1.. if entity @a[tag=ch.caster,distance=20..,limit=1] as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"titan",n:1}
