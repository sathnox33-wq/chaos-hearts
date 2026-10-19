spectate
data remove storage ch:tmp ret
$data modify storage ch:tmp ret set from storage ch:data returns[{pid:$(pid)}]
$data remove storage ch:data returns[{pid:$(pid)}]
clear @s minecraft:totem_of_undying[minecraft:custom_data~{ch:{ward:1}}]
stopsound @s record
effect clear @s
effect give @s minecraft:instant_health 1 4 true
effect give @s minecraft:resistance 3 4 true
scoreboard players set @s ch.trial 0
tag @s remove ch.challenger
execute unless data storage ch:tmp ret.pos run return run function ch:trial/return_spawn
data modify storage ch:tmp rp set value {}
data modify storage ch:tmp rp.dim set from storage ch:tmp ret.dim
data modify storage ch:tmp rp.gm set from storage ch:tmp ret.gm
data modify storage ch:tmp rp.x set from storage ch:tmp ret.pos[0]
data modify storage ch:tmp rp.y set from storage ch:tmp ret.pos[1]
data modify storage ch:tmp rp.z set from storage ch:tmp ret.pos[2]
data modify storage ch:tmp rp.yaw set from storage ch:tmp ret.rot[0]
data modify storage ch:tmp rp.pitch set from storage ch:tmp ret.rot[1]
function ch:trial/return3 with storage ch:tmp rp
