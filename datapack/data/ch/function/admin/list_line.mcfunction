# Internal: one line of the heart registry (to the admin who asked; from the console it goes to the log).
$tellraw @s {text:"heart $(id) $(type) $(state) holder $(holder) collector $(collector)",color:"gray"}
$execute unless entity @s run say heart $(id) $(type) $(state) holder $(holder) collector $(collector)
