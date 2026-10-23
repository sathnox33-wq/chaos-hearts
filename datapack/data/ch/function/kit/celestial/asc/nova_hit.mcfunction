# Caught in the Supernova.
execute store result score #ce_ok ch.tmp run function ch:kit/celestial/hit
execute unless score #ce_ok ch.tmp matches 1.. run return 0
function ch:api/cc {effect:"minecraft:blindness",sec:2,amp:0}
function ch:api/push {s:1.0,y:0.4}
