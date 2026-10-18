# Hands over hearts that came back while this player was offline.
execute store result score #me ch.tmp run scoreboard players get @s ch.pid
data modify storage ch:tmp plist set from storage ch:data pending
data modify storage ch:data pending set value []
function ch:heart/pending/loop
