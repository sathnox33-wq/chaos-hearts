# Cold Snap: +30% nova damage.
scoreboard players set #f_m ch.tmp 13
scoreboard players operation #f_nd ch.tmp *= #f_m ch.tmp
scoreboard players operation #f_nd ch.tmp /= #10 ch.g
