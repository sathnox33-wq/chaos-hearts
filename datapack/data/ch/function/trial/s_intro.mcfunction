# The intro cinematic: the camera orbits while the trial introduces itself, then the fight begins.
execute as @e[type=item_display,tag=ch.cam,distance=..40,limit=1] at @s run tp @s ^0.32 ^ ^0.02 facing entity @e[type=marker,tag=ch.session,distance=..40,limit=1] feet
execute if score #t ch.tmp matches 20 run function ch:trial/spectate_again
scoreboard players operation #i ch.tmp = #hid ch.tmp
execute if score #t ch.tmp matches 10 run function ch:gen/describe
execute if score #t ch.tmp matches 10 as @a[tag=ch.challenger,limit=1] run function ch:trial/intro_title with storage ch:tmp h
execute if score #t ch.tmp matches 90 run function ch:gen/describe
execute if score #t ch.tmp matches 90 as @a[tag=ch.challenger,limit=1] run function ch:trial/intro_title2 with storage ch:tmp h
execute if score #t ch.tmp matches 160 as @a[tag=ch.challenger,limit=1] run function ch:trial/intro_title3
$execute if score #t ch.tmp matches 200.. run function ch:trial/fight_begin {s:$(s)}
