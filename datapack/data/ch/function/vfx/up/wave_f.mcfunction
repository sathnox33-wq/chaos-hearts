# Frame of the wave layer: a dust ring at radius rr * (frame+1) / frames; the last frame adds the themed rim.
function ch:vfx/load_cur
execute store result score #wr ch.tmp run data get storage ch:vfx cur.rr
scoreboard players operation #wk ch.tmp = @s ch.t
scoreboard players add #wk ch.tmp 1
scoreboard players operation #wr ch.tmp *= #wk ch.tmp
scoreboard players operation #wr ch.tmp /= @s ch.life
execute store result storage ch:vfx np.r float 0.01 run scoreboard players get #wr ch.tmp
scoreboard players operation #wl ch.tmp = @s ch.life
scoreboard players remove #wl ch.tmp 1
execute if score #wr ch.tmp matches ..399 positioned ~ ~0.2 ~ run function ch:vfx/up/wave_r {n:32}
execute if score #wr ch.tmp matches 400.. positioned ~ ~0.2 ~ run function ch:vfx/up/wave_r {n:48}
execute if score @s ch.t = #wl ch.tmp positioned ~ ~0.35 ~ run function ch:vfx/up/wave_rim
