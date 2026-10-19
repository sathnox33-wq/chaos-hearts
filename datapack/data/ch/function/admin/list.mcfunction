# Op: prints every heart in the registry, one per line.
tellraw @s {text:"Heart registry:",color:"light_purple"}
data modify storage ch:tmp ls set from storage ch:reg hearts
function ch:admin/list_loop
