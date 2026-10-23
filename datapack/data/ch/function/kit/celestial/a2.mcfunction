# Sanctuary. Level: consecrated ground heals allies and weakens enemies. Up: Aegis, a smaller dome that throws
# enemies out. Down: Judgement, a circle that burns enemies inside and detonates when it ends.
scoreboard players operation #ce_pid ch.tmp = @s ch.pid
scoreboard players set #ce_r ch.tmp 50
scoreboard players set #ce_l ch.tmp 120
execute if score #var ch.tmp matches 1 run scoreboard players set #ce_r ch.tmp 35
execute if score #var ch.tmp matches 1 run scoreboard players set #ce_l ch.tmp 70
execute if score #var ch.tmp matches 2 run scoreboard players set #ce_l ch.tmp 80
execute if score @s ch.b2 matches 1.. run scoreboard players operation #ce_r ch.tmp *= #13 ch.celestial.k
execute if score @s ch.b2 matches 1.. run scoreboard players operation #ce_r ch.tmp /= #10 ch.g
execute if score @s ch.b2 matches 3.. run scoreboard players operation #ce_l ch.tmp *= #7 ch.celestial.k
execute if score @s ch.b2 matches 3.. run scoreboard players operation #ce_l ch.tmp /= #5 ch.celestial.k
scoreboard players operation @s ch.celestial.hp = @s ch.health
execute align y positioned ~0.5 ~ ~0.5 summon marker run function ch:kit/celestial/sanc/init
execute store result storage ch:tmp cs.r float 0.1 run scoreboard players get #ce_r ch.tmp
execute store result storage ch:tmp cs.d float 0.2 run scoreboard players get #ce_r ch.tmp
execute store result storage ch:tmp cs.l int 1 run scoreboard players get #ce_l ch.tmp
scoreboard players operation #ce_v ch.tmp = #var ch.tmp
execute align y positioned ~0.5 ~ ~0.5 run function ch:kit/celestial/sanc/open with storage ch:tmp cs
return 1
