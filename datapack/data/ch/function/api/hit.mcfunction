# As the target, with the caster tagged ch.caster: deals $(d) tenths of a point of ability damage (60 = 3 hearts)
# after the server, honed and PvP modifiers. Credits the caster, shows the hit indicator and awards mastery XP.
# Adds 1 to #hits ch.tmp when the hit lands.
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 unless entity @e[tag=ch.caster,tag=ch.tmob] run return fail
execute if entity @s[type=player,scores={ch.trial=1..}] if entity @a[tag=ch.caster,limit=1] run return fail
execute if entity @s[type=player] if entity @a[tag=ch.caster,scores={ch.trial=1..}] run return fail
execute if entity @s[tag=ch.tmob] if entity @e[tag=ch.caster,tag=ch.tmob,limit=1] run return fail
$scoreboard players set #d ch.tmp $(d)
scoreboard players operation #d ch.tmp *= #dmg_pct ch.cfg
scoreboard players operation #d ch.tmp /= #100 ch.g
execute if entity @a[tag=ch.caster,scores={ch.lvl=60..},limit=1] run scoreboard players operation #d ch.tmp *= #110 ch.g
execute if entity @a[tag=ch.caster,scores={ch.lvl=60..},limit=1] run scoreboard players operation #d ch.tmp /= #100 ch.g
execute if entity @s[type=player] if entity @a[tag=ch.caster,limit=1] run scoreboard players operation #d ch.tmp *= #pvp_pct ch.cfg
execute if entity @s[type=player] if entity @a[tag=ch.caster,limit=1] run scoreboard players operation #d ch.tmp /= #100 ch.g
execute if entity @e[tag=ch.caster,tag=ch.tmob,limit=1] run scoreboard players operation #d ch.tmp *= #trial_pct ch.cfg
execute if entity @e[tag=ch.caster,tag=ch.tmob,limit=1] run scoreboard players operation #d ch.tmp /= #100 ch.g
execute if score #d ch.tmp matches ..0 run return fail
execute store result storage ch:tmp dmg.w int 1 run scoreboard players operation #w ch.tmp = #d ch.tmp
scoreboard players operation #w ch.tmp /= #10 ch.g
execute store result storage ch:tmp dmg.w int 1 run scoreboard players get #w ch.tmp
scoreboard players operation #d ch.tmp %= #10 ch.g
execute store result storage ch:tmp dmg.f int 1 run scoreboard players get #d ch.tmp
function ch:api/hit_apply with storage ch:tmp dmg
function ch:api/hit_text with storage ch:tmp dmg
scoreboard players add #hits ch.tmp 1
particle minecraft:crit ~ ~1 ~ 0.3 0.4 0.3 0.25 8
execute as @a[tag=ch.caster,limit=1] at @s run function ch:api/hit_mark
execute if entity @s[type=player] run tag @s add ch.pairv
execute if entity @s[type=player] if entity @a[tag=ch.caster,limit=1] as @a[tag=ch.caster,limit=1] run function ch:combat/pair
tag @s remove ch.pairv
function ch:api/hit_xp
return 1
