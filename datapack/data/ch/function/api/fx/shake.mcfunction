# Shakes the camera of players within r blocks: strength s (1..3) for t ticks.
$scoreboard players set @a[distance=..$(r),gamemode=!spectator] ch.shake $(t)
$scoreboard players set @a[distance=..$(r),gamemode=!spectator] ch.shakes $(s)
