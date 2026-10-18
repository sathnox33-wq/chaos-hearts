$scoreboard players remove @s ch.cd$(s) 1
$execute if score @s ch.cd$(s) matches 0 run function ch:core/player/ready {s:$(s)}
