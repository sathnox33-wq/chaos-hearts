# A Rampage lifesteal gulp.
scoreboard players remove @s ch.rage.ls 40
function ch:api/heal {n:4}
particle minecraft:dust{color:[0.88,0.15,0.17],scale:1.6} ~ ~1.2 ~ 0.4 0.4 0.4 0 16
playsound minecraft:entity.generic.drink player @s ~ ~ ~ 0.6 0.6
