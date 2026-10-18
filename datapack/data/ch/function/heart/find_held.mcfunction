# Puts the registry id of a heart of type $(h) held by player $(pid) in #id ch.tmp (0 if missing).
scoreboard players set #id ch.tmp 0
data modify storage ch:tmp found set value []
$data modify storage ch:tmp found append from storage ch:reg hearts[{type:"$(h)",state:"held",holder:$(pid)}]
execute store result score #id ch.tmp run data get storage ch:tmp found[0].id
