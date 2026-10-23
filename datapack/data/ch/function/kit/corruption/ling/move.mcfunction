# One shambling step (stepping up single blocks), facing the way it walks.
execute if block ^ ^ ^0.4 #ch:passable if block ^ ^1 ^0.4 #ch:passable run return run tp @s ^ ^ ^0.2 ~ 0
execute if block ^ ^1 ^0.4 #ch:passable if block ^ ^2 ^0.4 #ch:passable run return run tp @s ^ ^1 ^0.2 ~ 0
tp @s ~ ~ ~ ~ 0
