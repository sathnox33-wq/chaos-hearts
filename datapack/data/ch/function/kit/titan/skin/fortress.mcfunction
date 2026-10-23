# Living Fortress: allies near the Titan get Resistance I for the skin's duration.
execute as @a[tag=!ch.caster,distance=..6,gamemode=!spectator] unless score @s ch.opp = #ti_pid ch.tmp at @s run function ch:kit/titan/skin/ally
