# The fight: the boss runs its patterns, the bar follows its health, phases trigger at 50% and 20%.
$execute unless entity @e[tag=ch.boss,distance=..120,limit=1] run return run function ch:trial/won {s:$(s)}
execute as @e[tag=ch.boss,distance=..120,limit=1] at @s run function ch:gen/trial_boss_tick
$execute store result bossbar ch:slot$(s) value run data get entity @e[tag=ch.boss,distance=..120,limit=1] Health
$execute store result score #hp ch.tmp run bossbar get ch:slot$(s) value
$execute store result score #mx ch.tmp run bossbar get ch:slot$(s) max
scoreboard players operation #hp ch.tmp *= #100 ch.g
execute if score #mx ch.tmp matches ..0 run scoreboard players set #mx ch.tmp 1
scoreboard players operation #hp ch.tmp /= #mx ch.tmp
$execute if score #hp ch.tmp matches ..50 if score #s$(s) ch.phase matches ..1 run function ch:trial/phase {s:$(s),p:2}
$execute if score #hp ch.tmp matches ..20 if score #s$(s) ch.phase matches ..2 run function ch:trial/phase {s:$(s),p:3}
