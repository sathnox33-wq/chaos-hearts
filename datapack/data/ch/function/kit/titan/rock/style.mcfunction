# Restyles a new boulder: the thrown block, yaw offset $(y), pitch offset $(p).
tag @s add ch.titan.rk
$data modify entity @s item.id set value "$(b)"
data merge entity @s {view_range:3.0f,interpolation_duration:2}
$tp @s ~ ~ ~ ~$(y) ~$(p)
