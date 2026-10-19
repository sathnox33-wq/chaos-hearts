# The heart awakens. A few seconds of glory, then home.
execute if score #t ch.tmp matches 1 run kill @e[tag=ch.tmob,distance=..120,type=!player]
execute if score #t ch.tmp matches 1 as @a[tag=ch.challenger,limit=1] at @s run function ch:trial/awaken
execute if score #t ch.tmp matches 1..60 if score #t20 ch.g matches 0 positioned as @a[tag=ch.challenger,limit=1] run particle minecraft:firework ~ ~2 ~ 1 1 1 0.15 80 force
execute if score #t ch.tmp matches 120.. as @a[tag=ch.challenger,limit=1] run function ch:trial/return
$execute if score #t ch.tmp matches 120.. run function ch:trial/cleanup {s:$(s)}
