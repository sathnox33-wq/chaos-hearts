# As one nearby player: Speed II unless they are in a fight with the Slipstream runner.
execute if score @s ch.opp = #pid ch.speed.g if score @s ch.ctag > #now ch.g run return 0
effect give @s minecraft:speed 2 1 true
particle minecraft:dust{color:[0.96,0.88,0.26],scale:0.7} ~ ~0.3 ~ 0.3 0.1 0.3 0 3
