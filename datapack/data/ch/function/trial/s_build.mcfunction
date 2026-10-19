# Waits for the arena chunks, clears the box, builds the themed arena, then brings the challenger in.
$execute if score #t ch.tmp matches 10 unless loaded ~ ~ ~ run return run scoreboard players set #s$(s) ch.t 9
execute if score #t ch.tmp matches 10 run function ch:trial/clear
execute if score #t ch.tmp matches 10 run kill @e[type=marker,tag=ch.session,distance=..2]
execute if score #t ch.tmp matches 10 run summon marker ~ ~ ~ {Tags:["ch.session","ch.noability"]}
$execute if score #t ch.tmp matches 10 run scoreboard players set @e[type=marker,tag=ch.session,distance=..2,limit=1] ch.slot $(s)
execute if score #t ch.tmp matches 10 as @e[type=marker,tag=ch.session,distance=..2,limit=1] at @s run function ch:gen/trial_build
execute if score #t ch.tmp matches 22.. run function ch:trial/to_intro
$execute if score #t ch.tmp matches 22.. run scoreboard players set #s$(s) ch.state 2
$execute if score #t ch.tmp matches 22.. run scoreboard players set #s$(s) ch.t 0
