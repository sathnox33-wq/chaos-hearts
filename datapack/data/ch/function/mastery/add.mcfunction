# Adds #x ch.tmp XP to heart $(h). Past 100 mastery on an awakened heart it becomes Ascension XP.
$execute if score @s ch.awk.$(h) matches 1 if score @s ch.lvl.$(h) matches 100.. run return run function ch:mastery/ascend {h:"$(h)"}
$scoreboard players operation @s ch.xp.$(h) += #x ch.tmp
$execute if score @s ch.xp.$(h) matches 23801.. run scoreboard players set @s ch.xp.$(h) 23800
$function ch:gen/level/$(h)
