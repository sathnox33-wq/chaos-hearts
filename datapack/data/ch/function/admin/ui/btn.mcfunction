# Appends an admin panel button with label $(l) that runs /trigger chadmin set $(c).
$data modify storage ch:tmp dl.actions append value {label:{text:"$(l)"},action:{type:"minecraft:run_command",command:"trigger chadmin set $(c)"}}
