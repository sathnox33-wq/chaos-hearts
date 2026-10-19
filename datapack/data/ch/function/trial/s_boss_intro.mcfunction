# The guardian appears, frozen while it is introduced.
execute if score #t ch.tmp matches 1 as @e[type=marker,tag=ch.session,distance=..2,limit=1] at @s run function ch:gen/trial_boss_spawn
execute if score #t ch.tmp matches 1 as @e[tag=ch.boss,distance=..90] run data merge entity @s {NoAI:1b}
execute if score #t ch.tmp matches 1 as @a[tag=ch.challenger,limit=1] at @s run function ch:trial/boss_title
execute if score #t ch.tmp matches 1 positioned as @a[tag=ch.challenger,limit=1] run function ch:api/fx/shake {s:3,t:30,r:8}
$execute if score #t ch.tmp matches 2 run bossbar set ch:slot$(s) players @a[tag=ch.challenger,limit=1]
$execute if score #t ch.tmp matches 2 run bossbar set ch:slot$(s) visible true
execute if score #t ch.tmp matches ..69 run return 0
execute as @e[tag=ch.boss,distance=..90] run data merge entity @s {NoAI:0b}
$scoreboard players set #s$(s) ch.state 5
$scoreboard players set #s$(s) ch.t 0
