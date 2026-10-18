$execute if score @s ch.lvl < #unlock$(s) ch.g run return run data modify storage ch:tmp hud append value {text:"[$(k) 🔒] ",color:"dark_gray"}
$execute if score @s ch.cd$(s) matches 0 run return run data modify storage ch:tmp hud append value {text:"[$(k) ✔] ",color:"green"}
$execute store result score #sec ch.tmp run scoreboard players get @s ch.cd$(s)
scoreboard players add #sec ch.tmp 19
scoreboard players operation #sec ch.tmp /= #20 ch.g
execute store result storage ch:tmp n.v int 1 run scoreboard players get #sec ch.tmp
data modify storage ch:tmp n.k set value ""
$data modify storage ch:tmp n.k set value "$(k)"
function ch:core/player/hud_cd with storage ch:tmp n
