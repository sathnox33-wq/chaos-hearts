# Call Lightning: three marks (under you, then where you are heading), each struck 25 ticks later.
execute if score @s ch.v2 matches 1 run tellraw @a[tag=ch.challenger] {text:"The sky charges above you!",color:"#4FA8FF",italic:true}
execute if score @s ch.v2 matches 1 as @a[tag=ch.challenger,limit=1] at @s positioned ~ 100 ~ run function ch:trials/storm/b/mark
execute if score @s ch.v2 matches 7 as @a[tag=ch.challenger,limit=1] at @s rotated ~ 0 positioned ^ ^ ^4 positioned ~ 100 ~ run function ch:trials/storm/b/mark
execute if score @s ch.v2 matches 13 as @a[tag=ch.challenger,limit=1] at @s rotated ~ 0 positioned ^ ^ ^7 positioned ~ 100 ~ run function ch:trials/storm/b/mark
execute if score @s ch.v2 matches 45.. run function ch:trials/storm/b/end
