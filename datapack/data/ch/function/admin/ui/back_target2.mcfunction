# Internal: sets the last button to pick player button code $(c).
$data modify storage ch:tmp dl.actions[-1].action.command set value "trigger chadmin set $(c)"
