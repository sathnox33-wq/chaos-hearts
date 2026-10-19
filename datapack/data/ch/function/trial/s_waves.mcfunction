# Three waves. The next one comes when the arena is clear.
$execute if score #t ch.tmp matches 1 run scoreboard players add #s$(s) ch.v1 1
$execute if score #t ch.tmp matches 1 store result storage ch:tmp tw.n int 1 run scoreboard players get #s$(s) ch.v1
execute if score #t ch.tmp matches 1 as @e[type=marker,tag=ch.session,distance=..2,limit=1] at @s run function ch:gen/trial_wave
execute if score #t ch.tmp matches 1 as @a[tag=ch.challenger,limit=1] run function ch:trial/wave_title with storage ch:tmp tw
execute if score #t ch.tmp matches ..40 run return 0
execute unless score #t20 ch.g matches 0 run return 0
execute if entity @e[tag=ch.tmob,type=!#ch:ignore,distance=..90,limit=1] run return 0
$execute if score #s$(s) ch.v1 matches ..2 run return run scoreboard players set #s$(s) ch.t 0
$scoreboard players set #s$(s) ch.state 4
$scoreboard players set #s$(s) ch.t 0
