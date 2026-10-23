# A boulder lands (as the projectile, its Titan tagged ch.caster): a blast of rock that hurts and throws.
data modify storage ch:tmp tg.b set from entity @s item.id
data modify storage ch:tmp tg.sz set value "s"
scoreboard players set #ti_d ch.tmp 80
execute if entity @a[tag=ch.caster,scores={ch.b3=1..},limit=1] run scoreboard players set #ti_d ch.tmp 104
scoreboard players set #ti_far ch.tmp 0
execute if score @s ch.life matches ..44 run scoreboard players set #ti_far ch.tmp 1
scoreboard players set #ti_r ch.tmp 0
execute if entity @a[tag=ch.caster,scores={ch.b3=2..},limit=1] run scoreboard players set #ti_r ch.tmp 1
function ch:kit/titan/rock/blast_fx with storage ch:tmp tg
scoreboard players set #hits ch.tmp 0
execute if score #ti_r ch.tmp matches 0 positioned ~ ~0.5 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..3] run function ch:kit/titan/rock/blast_hit
execute if score #ti_r ch.tmp matches 1 positioned ~ ~0.5 ~ as @e[type=!#ch:ignore,tag=!ch.caster,tag=!ch.noability,distance=..4.2] run function ch:kit/titan/rock/blast_hit
execute if score #hits ch.tmp matches 1.. if score #ti_far ch.tmp matches 1 as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"titan",n:1}
