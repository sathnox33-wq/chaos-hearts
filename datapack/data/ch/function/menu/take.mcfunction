# Takes the next node in branch $(b) of the active heart if it is awakened and the points are there.
execute unless function ch:menu/load run return run function ch:menu/main
execute unless score @s ch.awake matches 1 run return run function ch:menu/tree
$scoreboard players operation #n ch.tmp = @s ch.b$(b)
execute if score #n ch.tmp matches 5.. run return run function ch:menu/tree
function ch:menu/points with storage ch:tmp h
scoreboard players set #cost ch.tmp 1
execute if score #n ch.tmp matches 1..2 run scoreboard players set #cost ch.tmp 2
execute if score #n ch.tmp matches 3 run scoreboard players set #cost ch.tmp 3
execute if score #n ch.tmp matches 4 run scoreboard players set #cost ch.tmp 4
execute if score #avail ch.tmp < #cost ch.tmp run return run function ch:menu/take_fail {m:"Not enough skill points."}
execute if score #n ch.tmp matches 4 if score @s ch.b1 matches 5 run return run function ch:menu/take_fail {m:"You already have a capstone on this heart."}
execute if score #n ch.tmp matches 4 if score @s ch.b2 matches 5 run return run function ch:menu/take_fail {m:"You already have a capstone on this heart."}
execute if score #n ch.tmp matches 4 if score @s ch.b3 matches 5 run return run function ch:menu/take_fail {m:"You already have a capstone on this heart."}
$function ch:menu/take2 {b:$(b)}
