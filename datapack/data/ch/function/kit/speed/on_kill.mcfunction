# Speed kill: Blink Strike feat (a kill within 3 seconds of a Dash).
execute if score @s ch.speed.dsh matches 1.. run function ch:api/feat {h:"speed",n:0}
