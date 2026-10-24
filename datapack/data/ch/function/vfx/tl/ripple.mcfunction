# Timeline: rings racing outward, one per tick, 0.8 blocks further each time.
function ch:vfx/load_cur
scoreboard players operation #wr ch.tmp = @s ch.t
scoreboard players add #wr ch.tmp 1
execute store result storage ch:vfx cur.r float 0.8 run scoreboard players get #wr ch.tmp
data modify storage ch:vfx cur.p set from storage ch:vfx cur.d
execute positioned ~ ~0.15 ~ run function ch:gen/vfx/mring48 with storage ch:vfx cur
data modify storage ch:vfx cur.p set from storage ch:vfx cur.b
execute rotated ~4 0 positioned ~ ~0.25 ~ run function ch:gen/vfx/mring16 with storage ch:vfx cur
