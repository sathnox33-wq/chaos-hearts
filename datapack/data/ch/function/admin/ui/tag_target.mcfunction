# Tags the player this admin picked (ch.adt holds their id) ch.adtgt. Fails, with a note, if they are offline.
tag @a remove ch.adtgt
scoreboard players operation #o ch.tmp = @s ch.adt
execute as @a if score @s ch.pid = #o ch.tmp run tag @s add ch.adtgt
execute if entity @a[tag=ch.adtgt,limit=1] run return 1
tellraw @s {text:"That player is not online any more.",color:"red"}
return fail
