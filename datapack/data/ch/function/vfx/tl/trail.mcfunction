# Timeline (follows its owner): a dense motion trail at the feet and body.
function ch:vfx/load_cur
function ch:vfx/tl/trail_p with storage ch:vfx cur
execute if predicate ch:vfx/half run function ch:vfx/sh {s:"ring0_5",k:"e",v:0}
