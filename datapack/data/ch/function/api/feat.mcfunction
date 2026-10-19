# As a player: completes feat $(n) (0-3) of heart $(h) once, for its mastery XP. Returns fail if already done.
$scoreboard players operation #fb ch.tmp = @s ch.feat.$(h)
$scoreboard players set #n ch.tmp $(n)
scoreboard players set #bit ch.tmp 1
execute if score #n ch.tmp matches 1 run scoreboard players set #bit ch.tmp 2
execute if score #n ch.tmp matches 2 run scoreboard players set #bit ch.tmp 4
execute if score #n ch.tmp matches 3 run scoreboard players set #bit ch.tmp 8
scoreboard players operation #fb ch.tmp /= #bit ch.tmp
scoreboard players operation #fb ch.tmp %= #2 ch.g
execute if score #fb ch.tmp matches 1 run return fail
$scoreboard players operation @s ch.feat.$(h) += #bit ch.tmp
$data modify storage ch:tmp f set from storage ch:const menu.$(h).feats[$(n)]
$data modify storage ch:tmp f.h set value "$(h)"
$data modify storage ch:tmp f.color set from storage ch:const menu.$(h).color
function ch:api/feat2 with storage ch:tmp f
return 1
