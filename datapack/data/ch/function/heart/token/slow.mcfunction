# Once a second: return the heart when the window ran out, and drop stale copies.
execute store result storage ch:tmp t.id int 1 run scoreboard players get @s ch.hid
function ch:heart/token/validate with storage ch:tmp t
execute if score @s ch.t <= #now ch.g run function ch:heart/return with storage ch:tmp t
