# As Nyxara: a pounce toward the challenger.
function ch:api/vec {s:1.4}
scoreboard players set #vy ch.tmp 450
function ch:api/motion
playsound minecraft:entity.spider.hurt hostile @a ~ ~ ~ 2 0.4
particle minecraft:dust{color:[0.482,0.82,0.227],scale:2.0} ~ ~0.5 ~ 1 0.3 1 0 30
