$scoreboard players set #s$(s) ch.state 1
$scoreboard players set #s$(s) ch.t 0
$scoreboard players set #s$(s) ch.life 0
$scoreboard players set #s$(s) ch.phase 0
$scoreboard players set #s$(s) ch.v1 0
$scoreboard players set #s$(s) ch.owner $(pid)
$scoreboard players set #s$(s) ch.hid $(hid)
scoreboard players add #busy ch.g 1
$execute in ch:trials run forceload add $(x) 0
$execute in ch:trials positioned $(x) 0 0 run forceload add ~-48 ~-48 ~48 ~48
$data remove storage ch:data returns[{pid:$(pid)}]
data modify storage ch:tmp ret set value {}
$data modify storage ch:tmp ret.pid set value $(pid)
data modify storage ch:tmp ret.pos set from entity @s Pos
data modify storage ch:tmp ret.rot set from entity @s Rotation
data modify storage ch:tmp ret.dim set from entity @s Dimension
data modify storage ch:tmp ret.gm set value "survival"
execute if entity @s[gamemode=adventure] run data modify storage ch:tmp ret.gm set value "adventure"
execute if entity @s[gamemode=creative] run data modify storage ch:tmp ret.gm set value "creative"
data modify storage ch:data returns append from storage ch:tmp ret
$scoreboard players set @s ch.trial $(s)
scoreboard players add @s ch.trial 1
function ch:trial/enter_fx
