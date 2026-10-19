# One tick of the trial in slot $(s), at the arena centre.
# States: 1 build, 2 intro cinematic, 3 waves, 4 boss intro, 5 boss, 6 victory.
$scoreboard players set #slot ch.tmp $(s)
$scoreboard players operation #hid ch.tmp = #s$(s) ch.hid
$scoreboard players add #s$(s) ch.t 1
$scoreboard players add #s$(s) ch.life 1
$scoreboard players operation #t ch.tmp = #s$(s) ch.t
$scoreboard players operation #st ch.tmp = #s$(s) ch.state
tag @a remove ch.challenger
scoreboard players operation #tr ch.tmp = #slot ch.tmp
scoreboard players add #tr ch.tmp 1
execute as @a if score @s ch.trial = #tr ch.tmp run tag @s add ch.challenger
$execute unless entity @a[tag=ch.challenger,limit=1] if score #s$(s) ch.t matches 40.. run return run function ch:trial/abandon {s:$(s)}
scoreboard players operation #lim ch.tmp = #trial_min ch.cfg
scoreboard players operation #lim ch.tmp *= #1200 ch.g
$execute if score #s$(s) ch.life > #lim ch.tmp as @a[tag=ch.challenger,limit=1] run return run function ch:trial/fail {s:$(s),why:"Time ran out."}
$execute if score #st ch.tmp matches 1 run return run function ch:trial/s_build {s:$(s)}
$execute if score #st ch.tmp matches 2 run return run function ch:trial/s_intro {s:$(s)}
execute if score #st ch.tmp matches 3..5 as @e[type=marker,tag=ch.session,distance=..2,limit=1] at @s run function ch:gen/trial_ambient
execute if score #st ch.tmp matches 3..5 run function ch:trial/guard
$execute if score #st ch.tmp matches 3 run return run function ch:trial/s_waves {s:$(s)}
$execute if score #st ch.tmp matches 4 run return run function ch:trial/s_boss_intro {s:$(s)}
$execute if score #st ch.tmp matches 5 run return run function ch:trial/s_boss {s:$(s)}
$execute if score #st ch.tmp matches 6 run return run function ch:trial/s_victory {s:$(s)}
