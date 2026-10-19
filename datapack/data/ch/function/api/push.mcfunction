# As the target, executed at the push origin: knocks the target away from the origin.
# Mobs get exact motion of $(s) blocks per tick plus a lift of $(y); players get a wind burst (and levitation if $(y) > 0.5).
execute if entity @s[type=#ch:ignore] run return fail
execute if entity @s[tag=ch.noability] run return fail
execute if entity @s[tag=ch.caster] run return fail
execute if entity @s[tag=ch.boss] run return fail
execute if entity @s[type=player,gamemode=!survival,gamemode=!adventure] run return fail
execute if entity @s[type=player] if score #pvp ch.g matches 0 run return fail
$execute if entity @s[type=player] facing entity @s feet positioned as @s run return run function ch:api/push_player {y:$(y)}
$execute facing entity @s feet in ch:trials positioned 0.0 0.0 0.0 run tp @e[type=marker,tag=ch.vec,limit=1] ^ ^ ^$(s)
execute store result score #vx ch.tmp run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[0] 1000
execute store result score #vz ch.tmp run data get entity @e[type=marker,tag=ch.vec,limit=1] Pos[2] 1000
execute store result entity @s Motion[0] double 0.001 run scoreboard players get #vx ch.tmp
execute store result entity @s Motion[2] double 0.001 run scoreboard players get #vz ch.tmp
$data modify entity @s Motion[1] set value $(y)d
execute in ch:trials run tp @e[type=marker,tag=ch.vec,limit=1] 0.5 64 0.5
return 1
