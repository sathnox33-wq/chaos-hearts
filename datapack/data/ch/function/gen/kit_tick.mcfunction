# Generated: runs each heart's per-player and world tick.
execute as @a[scores={ch.active=1}] at @s run function ch:kit/rage/tick
execute as @a[scores={ch.active=2}] at @s run function ch:kit/speed/tick
execute as @a[scores={ch.active=3}] at @s run function ch:kit/infernal/tick
execute as @a[scores={ch.active=4}] at @s run function ch:kit/void/tick
execute as @a[scores={ch.active=5}] at @s run function ch:kit/frozen/tick
execute as @a[scores={ch.active=6}] at @s run function ch:kit/storm/tick
execute as @a[scores={ch.active=7}] at @s run function ch:kit/blood/tick
execute as @a[scores={ch.active=8}] at @s run function ch:kit/titan/tick
execute as @a[scores={ch.active=9}] at @s run function ch:kit/celestial/tick
execute as @a[scores={ch.active=10}] at @s run function ch:kit/corruption/tick
function ch:kit/rage/world_tick
function ch:kit/speed/world_tick
function ch:kit/infernal/world_tick
function ch:kit/void/world_tick
function ch:kit/frozen/world_tick
function ch:kit/storm/world_tick
function ch:kit/blood/world_tick
function ch:kit/titan/world_tick
function ch:kit/celestial/world_tick
function ch:kit/corruption/world_tick
