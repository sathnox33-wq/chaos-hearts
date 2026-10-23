# Multiplies #i_hd ch.tmp by $(m) percent.
$scoreboard players set #i_m ch.tmp $(m)
scoreboard players operation #i_hd ch.tmp *= #i_m ch.tmp
scoreboard players operation #i_hd ch.tmp /= #100 ch.g
