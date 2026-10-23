# Caught by a Colossus shockwave: damage and thrown from it.
execute store result score #ti_ok ch.tmp run function ch:kit/titan/hit
execute unless score #ti_ok ch.tmp matches 1.. run return 0
function ch:api/push {s:0.7,y:0.3}
