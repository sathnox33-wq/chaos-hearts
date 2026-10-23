# The flame wave grows 0.8 blocks a tick; a grounded challenger inside its band is burned once.
scoreboard players add @s ch.v1 8
scoreboard players remove @s ch.life 1
execute if score @s ch.life matches ..0 run return run function ch:trials/infernal/wave_end
execute store result storage ch:tmp kt.r float 0.1 run scoreboard players get @s ch.v1
scoreboard players operation #ib ch.tmp = @s ch.v1
scoreboard players remove #ib ch.tmp 9
execute store result storage ch:tmp kt.lo float 0.1 run scoreboard players get #ib ch.tmp
scoreboard players add #ib ch.tmp 18
execute store result storage ch:tmp kt.hi float 0.1 run scoreboard players get #ib ch.tmp
function ch:trials/infernal/wave_ring with storage ch:tmp kt
