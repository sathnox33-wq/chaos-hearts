# Mastery for heart $(h) rose from #old to #lvl. Announces the milestones that were crossed.
$execute if score @s ch.active matches $(i) run function ch:gen/sync_active
$scoreboard players set #i ch.tmp $(i)
function ch:gen/describe
execute store result storage ch:tmp h.lvl int 1 run scoreboard players get #lvl ch.tmp
function ch:mastery/level_msg with storage ch:tmp h
execute if score #old ch.tmp matches ..9 if score #lvl ch.tmp matches 10.. run function ch:mastery/milestone {m:"Ability 2 unlocked: sneak + sprint"}
execute if score #old ch.tmp matches ..24 if score #lvl ch.tmp matches 25.. run function ch:mastery/milestone {m:"Second passive unlocked, and your heart glows"}
execute if score #old ch.tmp matches ..39 if score #lvl ch.tmp matches 40.. run function ch:mastery/milestone {m:"Ability 3 unlocked: sneak + double-tap A"}
execute if score #old ch.tmp matches ..59 if score #lvl ch.tmp matches 60.. run function ch:mastery/milestone {m:"Honed: 15% shorter cooldowns and 10% more damage"}
execute if score #old ch.tmp matches ..74 if score #lvl ch.tmp matches 75.. run function ch:mastery/milestone {m:"Ultimate unlocked: sneak + double-tap D"}
execute if score #old ch.tmp matches ..89 if score #lvl ch.tmp matches 90.. run function ch:mastery/milestone {m:"Your heart now shows its aura"}
execute if score #old ch.tmp matches ..99 if score #lvl ch.tmp matches 100.. run function ch:mastery/milestone {m:"Mastery 100: the Awakening Trial is open. /trigger hearts"}
