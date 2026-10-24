# The level in big digits, right-aligned in three slots (digit glyph index = slot * 10 + digit).
execute if score #ml ch.tmp matches 100.. run function ch:core/hud/mb_at_n {c:1}
execute if score #ml ch.tmp matches 100.. run function ch:core/hud/mb_at_n {c:10}
execute if score #ml ch.tmp matches 100.. run return run function ch:core/hud/mb_at_n {c:20}
scoreboard players operation #d ch.tmp = #ml ch.tmp
scoreboard players operation #d ch.tmp /= #10 ch.g
scoreboard players add #d ch.tmp 10
execute if score #ml ch.tmp matches 10.. run function ch:core/hud/mb_digit
scoreboard players operation #d ch.tmp = #ml ch.tmp
scoreboard players operation #d ch.tmp %= #10 ch.g
scoreboard players add #d ch.tmp 20
function ch:core/hud/mb_digit
