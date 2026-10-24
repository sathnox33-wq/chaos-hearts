# Flips setting $(k) ch.cfg between 0 and 1.
$execute store success score #tg ch.tmp if score $(k) ch.cfg matches 1
$execute if score #tg ch.tmp matches 1 run scoreboard players set $(k) ch.cfg 0
$execute if score #tg ch.tmp matches 0 run scoreboard players set $(k) ch.cfg 1
