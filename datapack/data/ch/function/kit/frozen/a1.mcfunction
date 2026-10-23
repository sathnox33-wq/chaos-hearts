# Ice Shard. Level: a piercing shard (a fan of three with Hailstorm, a Glacial Lance at full Frost). Up: icicles rain on the spot you aim at. Down: Frost Step, spring back and leave an ice decoy that bursts.
scoreboard players operation #f_var ch.tmp = #var ch.tmp
execute if score #f_var ch.tmp matches 1 run return run function ch:kit/frozen/shard/rain
execute if score #f_var ch.tmp matches 2 run return run function ch:kit/frozen/shard/step
execute if score @s ch.frozen.frost matches 100.. run return run function ch:kit/frozen/shard/lance
return run function ch:kit/frozen/shard/fire
