execute as @e[type=item_display,tag=ch.token] at @s run function ch:heart/token/tick
execute if score #t20 ch.g matches 0 as @e[type=text_display,tag=ch.tokenlabel] at @s run function ch:heart/token/label_check
