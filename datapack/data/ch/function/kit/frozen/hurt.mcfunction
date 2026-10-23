# As a target, caster tagged: #f_dmg tenths of Frozen damage. Permafrost (awakened): frozen targets shatter for +40%.
scoreboard players operation #f_hd ch.tmp = #f_dmg ch.tmp
scoreboard players set #f_sh ch.tmp 0
execute if entity @s[tag=ch.frozen.solid] if entity @a[tag=ch.caster,scores={ch.active=5,ch.awake=1},limit=1] run scoreboard players set #f_sh ch.tmp 1
execute if score #f_sh ch.tmp matches 1 run function ch:kit/frozen/mul {m:140}
execute store result storage ch:tmp kh.d int 1 run scoreboard players get #f_hd ch.tmp
execute store result score #f_ok ch.tmp run function ch:api/hit with storage ch:tmp kh
execute if score #f_ok ch.tmp matches 0 run return fail
execute if score #f_sh ch.tmp matches 1 run function ch:kit/frozen/shatter
scoreboard players set #f_fg ch.tmp 6
execute as @a[tag=ch.caster,scores={ch.active=5},limit=1] run function ch:kit/frozen/frost
return 1
