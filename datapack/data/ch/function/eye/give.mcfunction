# The Eye grants a heart: a beam of darkness from the eye to the player, then the heart is theirs.
$execute as $(player) at @s run function ch:eye/beam_fx
$function ch:admin/give {player:"$(player)",heart:"$(heart)"}
