# As a shaking player: alternating offsets that add up to zero, so the view ends where it started.
scoreboard players remove @s ch.shake 1
scoreboard players operation #k ch.tmp = @s ch.shake
scoreboard players operation #k ch.tmp %= #4 ch.g
execute if score @s ch.shakes matches ..1 run return run function ch:api/fx/shake1
execute if score @s ch.shakes matches 2 run return run function ch:api/fx/shake2
function ch:api/fx/shake3
