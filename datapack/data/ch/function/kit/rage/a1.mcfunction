# Rage Leap. Level: a long arcing leap (farther while moving forward) that slams where you land. Up: Skyfall, a rocket
# into the sky, a hang that marks the ground, then a meteor dive that hits harder the higher it falls. Down:
# Earthsplitter, a fist to the ground and a fissure that rips forward, launching everything on it.
execute unless score @s ch.rage.ava matches 1.. run scoreboard players set @s ch.rage.avu 0
execute if score @s ch.rage.ava matches 1.. run function ch:kit/rage/leap/ava_use
execute if score #var ch.tmp matches 2 run function ch:kit/rage/fissure/start
execute if score #var ch.tmp matches 1 run function ch:kit/rage/leap/sky
execute if score #var ch.tmp matches 0 run function ch:kit/rage/leap/level
execute if score @s ch.b3 matches 3.. if score @s ch.cd1 matches 0 run function ch:api/cooldown {slot:1,t:150}
return 1
