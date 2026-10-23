# Speed, every tick for its holder: Swift, Momentum, Slippery, the running timers, Lightspeed and the aura.
execute if score #t20 ch.g matches 0 run attribute @s minecraft:movement_speed modifier add ch:speed_swift 0.15 add_multiplied_total
execute if score @s ch.lvl matches 25.. run function ch:kit/speed/p/momentum
execute unless score @s ch.lvl matches 25.. run scoreboard players set @s ch.meter 0
execute if score @s ch.b2 matches 3.. run function ch:kit/speed/p/slippery
execute if score @s ch.speed.dsh matches 1.. run scoreboard players remove @s ch.speed.dsh 1
execute if score @s ch.speed.slip matches 1.. run function ch:kit/speed/slip/tick
execute if score @s ch.speed.van matches 1.. run function ch:kit/speed/van/tick
execute if score @s ch.awake matches 1 if score #t2 ch.speed.g matches 0 if predicate ch:sprinting run function ch:kit/speed/p/lightspeed
execute if score @s ch.lvl matches 90.. if score #t4 ch.speed.g matches 0 run function ch:kit/speed/p/aura
