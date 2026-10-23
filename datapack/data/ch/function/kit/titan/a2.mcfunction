# Stone Skin. Level: Resistance II and unshakable footing. Up: Obsidian Shell, near-invulnerable but rooted,
# and it bursts with the force it absorbed. Down: Rockbind, stone grips the legs of every enemy near you.
scoreboard players operation #ti_pid ch.tmp = @s ch.pid
execute if score @s ch.titan.skin matches 1.. run return fail
execute if score #var ch.tmp matches 1 run return run function ch:kit/titan/skin/shell
execute if score #var ch.tmp matches 2 run return run function ch:kit/titan/skin/bind
return run function ch:kit/titan/skin/stone
