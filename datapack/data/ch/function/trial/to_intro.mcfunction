# The challenger arrives as a spectator riding a camera that circles the arena.
execute as @a[tag=ch.challenger,limit=1] run tp @s ~ ~1 ~-12 facing ~ ~1 ~
summon item_display ~ ~9 ~-20 {Tags:["ch.cam","ch.tmob","ch.noability"],teleport_duration:2}
execute as @e[type=item_display,tag=ch.cam,distance=..40,limit=1] at @s run tp @s ~ ~ ~ facing ~ 102 ~20
gamemode spectator @a[tag=ch.challenger,limit=1]
execute as @a[tag=ch.challenger,limit=1] run spectate @e[type=item_display,tag=ch.cam,distance=..40,limit=1] @s
execute as @e[type=marker,tag=ch.session,distance=..2,limit=1] at @s run function ch:gen/trial_intro
scoreboard players operation #i ch.tmp = #hid ch.tmp
function ch:gen/describe
execute as @a[tag=ch.challenger,limit=1] run function ch:trial/music with storage ch:tmp h
