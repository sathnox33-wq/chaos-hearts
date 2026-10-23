# Multiplies #f_hd ch.tmp by $(m) percent.
$scoreboard players set #f_m ch.tmp $(m)
scoreboard players operation #f_hd ch.tmp *= #f_m ch.tmp
scoreboard players operation #f_hd ch.tmp /= #100 ch.g
