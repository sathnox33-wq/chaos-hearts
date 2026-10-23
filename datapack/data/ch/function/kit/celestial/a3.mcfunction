# Radiant Beam. Level: gather light for 6 ticks, then a piercing lance along your aim. Up: Dawnbreaker, a
# 2.5 s channelled beam that follows your look. Down: Prism Nova, eight rays burst out after a marked windup.
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
execute if score @s ch.celestial.bm matches 1.. run return fail
function ch:kit/celestial/exalt
scoreboard players set #ce_d ch.tmp 80
execute if score @s ch.b3 matches 1.. run scoreboard players set #ce_d ch.tmp 100
execute if score #ce_ex ch.tmp matches 1 run scoreboard players operation #ce_d ch.tmp *= #3 ch.celestial.k
execute if score #ce_ex ch.tmp matches 1 run scoreboard players operation #ce_d ch.tmp /= #2 ch.g
scoreboard players operation #ce_r ch.tmp = #ce_ex ch.tmp
scoreboard players set #ce_sm ch.tmp 0
scoreboard players set #ce_co ch.tmp 0
scoreboard players set #ce_as ch.tmp 0
scoreboard players set #ce_nv ch.tmp 0
execute if score #var ch.tmp matches 1 run return run function ch:kit/celestial/beam/dawn
execute if score #var ch.tmp matches 2 run return run function ch:kit/celestial/beam/nova
function ch:kit/celestial/beam/gather
function ch:kit/celestial/fx/later {t:6,then:"ch:kit/celestial/beam/fire_l"}
return 1
