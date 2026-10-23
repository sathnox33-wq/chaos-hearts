# Moves the current forward (dy $(dy)) and strikes there.
$execute rotated as @s positioned ^ ^ ^1 run tp @s ~ ~$(dy) ~
execute at @s run function ch:kit/storm/ls/current_fx
