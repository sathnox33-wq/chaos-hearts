# As the target of a landed hit: mastery XP for the caster, less for hitting the same target again and again.
execute unless entity @s[type=player] unless entity @s[type=#ch:hostile] unless entity @s[tag=ch.tmob] run return 0
execute unless score @s ch.eid matches 1.. run function ch:api/new_eid
scoreboard players operation #e ch.tmp = @s ch.eid
execute if entity @s[type=player] run scoreboard players operation #x ch.tmp = #xp_hit_player ch.cfg
execute unless entity @s[type=player] run scoreboard players operation #x ch.tmp = #xp_hit_mob ch.cfg
execute unless entity @s[type=player] store result score #hp ch.tmp run data get entity @s Health
execute unless entity @s[type=player] if score #hp ch.tmp matches ..0 run scoreboard players operation #x ch.tmp += #xp_kill_mob ch.cfg
execute as @a[tag=ch.caster,limit=1] run function ch:api/hit_xp2
