# As the target, executed at the origin: pulls the target toward the origin.
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[tag=ch.boss] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 run return fail
execute if entity @s[type=player] facing entity @s feet positioned as @s rotated ~180 ~ run return run function ch:api/push_player
$execute facing entity @s feet rotated ~180 0 run function ch:api/vec {s:$(s)}
scoreboard players set #vy ch.tmp 250
function ch:api/motion
return 1
