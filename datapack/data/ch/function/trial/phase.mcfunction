$scoreboard players set #s$(s) ch.phase $(p)
$data modify storage ch:tmp tw.p set value $(p)
execute as @e[tag=ch.boss,distance=..120,limit=1] at @s run function ch:gen/trial_phase
execute as @a[tag=ch.challenger,limit=1] at @s run function ch:api/fx/shake {s:3,t:24,r:6}
playsound chaoshearts:boss_phase master @a[tag=ch.challenger] ~ ~ ~ 1.2 1
$bossbar set ch:slot$(s) style notched_$(p)0
