# As the target, executed at the push origin: knocks the target away from the origin.
# Mobs get exact motion of $(s) blocks per tick plus a lift of $(y); players get a wind burst.
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[tag=ch.boss] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 unless entity @e[tag=ch.caster,tag=ch.tmob] run return fail
execute if entity @s[type=player] facing entity @s feet positioned as @s run return run function ch:api/push_player
$execute facing entity @s feet rotated ~ 0 run function ch:api/vec {s:$(s)}
$data modify storage ch:tmp y set value $(y)
execute store result score #vy ch.tmp run data get storage ch:tmp y 1000
function ch:api/motion
return 1
