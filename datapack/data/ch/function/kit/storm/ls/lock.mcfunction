# The ray found someone: remember who, so the bolt can follow them for a moment.
execute unless score @s ch.eid matches 1.. run function ch:api/new_eid
scoreboard players operation #v2 ch.storm.g = @s ch.eid
