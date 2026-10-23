# Magma Eruption. Level: mark the ground you aim at; it erupts after a second. Moving: a fissure races ahead and erupts in a chain. Up: molten bombs fall on nearby foes. Down: erupt beneath yourself and ride the blast skyward.
scoreboard players operation #i_var ch.tmp = #var ch.tmp
scoreboard players operation #i_mov ch.tmp = #mov ch.tmp
function ch:kit/infernal/overheat
function ch:kit/infernal/pal
execute if score #i_var ch.tmp matches 1 run return run function ch:kit/infernal/erupt/rain
execute if score #i_var ch.tmp matches 2 run return run function ch:kit/infernal/erupt/self
execute if score #i_mov ch.tmp matches 1 run return run function ch:kit/infernal/erupt/fissure
return run function ch:kit/infernal/erupt/aim
