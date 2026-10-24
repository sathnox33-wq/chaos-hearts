# Internal: moves and turns the timeline marker, then runs its frame function at its new position.
$tp @s ^ ^$(dy) ^$(fw) ~$(spin) ~
$execute at @s run function $(f)
