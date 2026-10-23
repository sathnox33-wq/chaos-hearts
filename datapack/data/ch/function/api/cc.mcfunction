# As the target: crowd control $(effect) for $(sec) seconds at amplifier $(amp).
# Players and bosses get #cc_pct of the duration, and players are immune to more crowd control for 3 seconds after.
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score @s ch.ccimm matches 1.. run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 unless entity @e[tag=ch.caster,tag=ch.tmob] run return fail
$scoreboard players set #t ch.tmp $(sec)
scoreboard players operation #t ch.tmp *= #20 ch.g
execute if entity @s[type=player] run scoreboard players operation #t ch.tmp *= #cc_pct ch.cfg
execute if entity @s[type=player] run scoreboard players operation #t ch.tmp /= #100 ch.g
execute if entity @s[tag=ch.boss] run scoreboard players operation #t ch.tmp *= #cc_pct ch.cfg
execute if entity @s[tag=ch.boss] run scoreboard players operation #t ch.tmp /= #100 ch.g
execute if entity @s[type=player] run scoreboard players operation @s ch.ccimm = #t ch.tmp
execute if entity @s[type=player] run scoreboard players add @s ch.ccimm 60
scoreboard players add #t ch.tmp 19
scoreboard players operation #t ch.tmp /= #20 ch.g
$data modify storage ch:tmp cc set value {effect:"$(effect)",amp:$(amp)}
execute store result storage ch:tmp cc.s int 1 run scoreboard players get #t ch.tmp
function ch:api/cc_apply with storage ch:tmp cc
return 1
