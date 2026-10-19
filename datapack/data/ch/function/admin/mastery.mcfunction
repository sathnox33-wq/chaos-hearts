# Op: sets $(player)'s mastery on heart $(heart) to level $(level) (0..100).
$scoreboard players set #lvl ch.tmp $(level)
execute if score #lvl ch.tmp matches 101.. run scoreboard players set #lvl ch.tmp 100
execute if score #lvl ch.tmp matches ..-1 run scoreboard players set #lvl ch.tmp 0
scoreboard players operation #need ch.tmp = #lvl ch.tmp
function ch:mastery/total
$execute as $(player) run function ch:admin/mastery2 {h:"$(heart)"}
$tellraw @s [{text:"Set $(heart) mastery to $(level) for ",color:"gray"},{selector:"$(player)",color:"white"}]
