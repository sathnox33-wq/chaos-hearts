# As the target: roots it in place (no walking, no jumping) for $(t) ticks. Players and bosses get #cc_pct of it,
# and players are immune to more crowd control for 3 seconds after.
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score @s ch.ccimm matches 1.. run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 unless entity @e[tag=ch.caster,tag=ch.tmob] run return fail
$scoreboard players set #t ch.tmp $(t)
execute if entity @s[type=player] run scoreboard players operation #t ch.tmp *= #cc_pct ch.cfg
execute if entity @s[type=player] run scoreboard players operation #t ch.tmp /= #100 ch.g
execute if entity @s[tag=ch.boss] run scoreboard players operation #t ch.tmp *= #cc_pct ch.cfg
execute if entity @s[tag=ch.boss] run scoreboard players operation #t ch.tmp /= #100 ch.g
execute if entity @s[type=player] run scoreboard players operation @s ch.ccimm = #t ch.tmp
execute if entity @s[type=player] run scoreboard players add @s ch.ccimm 60
execute if score @s ch.stun > #t ch.tmp run return 1
scoreboard players operation @s ch.stun = #t ch.tmp
attribute @s minecraft:movement_speed modifier add ch:stun -1 add_multiplied_total
attribute @s minecraft:jump_strength modifier add ch:stun -1 add_multiplied_total
scoreboard players set #stuns ch.g 1
return 1
