# Moves registry heart $(id) to player $(pid) (this player) and gives it to them.
$data modify storage ch:reg hearts[{id:$(id)}] merge value {state:"held",holder:$(pid)}
$data remove storage ch:reg hearts[{id:$(id)}].collector
$data remove storage ch:reg hearts[{id:$(id)}].exp
$data remove storage ch:reg hearts[{id:$(id)}].pos
$function ch:heart/gain {id:$(id),h:"$(h)",i:$(i)}
