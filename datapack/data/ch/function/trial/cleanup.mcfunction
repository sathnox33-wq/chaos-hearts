# Closes slot $(s): removes everything the trial made, clears the blocks, frees the chunks.
$execute store result storage ch:tmp cl.x int 1024 run scoreboard players set #c ch.tmp $(s)
$data modify storage ch:tmp cl.s set value $(s)
function ch:trial/cleanup_at with storage ch:tmp cl
$bossbar set ch:slot$(s) visible false
$bossbar set ch:slot$(s) players
$scoreboard players set #s$(s) ch.state 0
scoreboard players remove #busy ch.g 1
execute if score #busy ch.g matches ..-1 run scoreboard players set #busy ch.g 0
