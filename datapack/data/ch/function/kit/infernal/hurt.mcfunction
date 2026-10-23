# As a target, caster tagged: deals #i_dmg tenths of Infernal damage after Scorch, Heat (+1% per 5) and Overheat (+40%).
scoreboard players operation #i_hd ch.tmp = #i_dmg ch.tmp
execute store result score #i_f ch.tmp run data get entity @s Fire
execute if score #i_f ch.tmp matches 1.. if entity @a[tag=ch.caster,scores={ch.active=3,ch.b1=4..},limit=1] run function ch:kit/infernal/mul {m:115}
scoreboard players set #i_hb ch.tmp 0
execute store result score #i_hb ch.tmp run scoreboard players get @a[tag=ch.caster,limit=1] ch.infernal.heat
scoreboard players operation #i_hb ch.tmp /= #10 ch.g
scoreboard players operation #i_hb ch.tmp /= #2 ch.g
scoreboard players add #i_hb ch.tmp 100
scoreboard players operation #i_hd ch.tmp *= #i_hb ch.tmp
scoreboard players operation #i_hd ch.tmp /= #100 ch.g
execute if entity @a[tag=ch.caster,scores={ch.infernal.ovh=1..},limit=1] run function ch:kit/infernal/mul {m:140}
execute store result storage ch:tmp kh.d int 1 run scoreboard players get #i_hd ch.tmp
execute store result score #i_ok ch.tmp run function ch:api/hit with storage ch:tmp kh
execute if score #i_ok ch.tmp matches 0 run return fail
execute as @a[tag=ch.caster,scores={ch.active=3},limit=1] run function ch:kit/infernal/heat_hit
return 1
