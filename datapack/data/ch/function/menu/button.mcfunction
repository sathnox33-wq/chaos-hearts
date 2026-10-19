# Appends a button with label $(l) that runs trigger chmenu set $(c).
$data modify storage ch:tmp dl.actions append value {label:{text:"$(l)"},action:{type:"minecraft:run_command",command:"trigger chmenu set $(c)"}}
