# Static Field: four charged copper zones crackle for 10 seconds.
scoreboard players set @s ch.v5 0
tellraw @a[tag=ch.challenger] {text:"The copper hums with static!",color:"#4FA8FF",italic:true}
function ch:trials/storm/b/zone_rand
function ch:trials/storm/b/zone_rand
function ch:trials/storm/b/zone_rand
execute as @a[tag=ch.challenger,limit=1] at @s positioned ~ 100 ~ run function ch:trials/storm/b/zone
