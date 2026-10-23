# As an armour vault, once a second: if its owner is online and no longer vanished, the armour goes back.
scoreboard players operation #o ch.speed.g = @s ch.owner
execute as @a if score @s ch.pid = #o ch.speed.g unless score @s ch.speed.van matches 1.. at @s run function ch:kit/speed/van/unvault
