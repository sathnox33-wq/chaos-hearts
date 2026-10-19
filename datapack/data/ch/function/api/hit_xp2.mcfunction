# As the caster: XP = base x 2 / (hits on this target in the last 10 seconds + 1).
execute unless score @s ch.tgt = #e ch.tmp run scoreboard players set @s ch.tgtn 0
execute if score @s ch.tgtt matches ..0 run scoreboard players set @s ch.tgtn 0
scoreboard players operation @s ch.tgt = #e ch.tmp
execute if score @s ch.tgtn matches ..19 run scoreboard players add @s ch.tgtn 1
scoreboard players set @s ch.tgtt 200
scoreboard players operation #x ch.tmp *= #2 ch.g
scoreboard players operation #div ch.tmp = @s ch.tgtn
scoreboard players add #div ch.tmp 1
scoreboard players operation #x ch.tmp /= #div ch.tmp
function ch:mastery/award
