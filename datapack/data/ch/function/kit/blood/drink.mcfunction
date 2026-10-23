# Drinks #dk ch.tmp tenths of health: banked and swallowed in 2-heart gulps. Counts Insatiable and Feast, fills
# Vitae. #bk ch.tmp 1 lets overhealing become absorption (Bloodbank); awakened always does.
execute if score #dk ch.tmp matches ..0 run return 0
scoreboard players operation @s ch.blood.bank += #dk ch.tmp
scoreboard players operation @s ch.blood.tot += #dk ch.tmp
execute if score @s ch.blood.tot matches 5000.. run function ch:api/feat {h:"blood",n:0}
execute if score @s ch.blood.moon matches 1.. run scoreboard players operation @s ch.blood.mheal += #dk ch.tmp
execute if score @s ch.blood.moon matches 1.. if score @s ch.blood.mheal matches 200.. run function ch:api/feat {h:"blood",n:3}
scoreboard players operation #vg ch.tmp = #dk ch.tmp
scoreboard players operation #vg ch.tmp /= #2 ch.g
scoreboard players operation @s ch.blood.vit += #vg ch.tmp
execute if score @s ch.blood.vit matches 101.. run scoreboard players set @s ch.blood.vit 100
scoreboard players operation @s ch.meter = @s ch.blood.vit
execute if score @s ch.blood.bank matches 40.. run function ch:kit/blood/gulp
execute if score @s ch.blood.bank matches 40.. run function ch:kit/blood/gulp
