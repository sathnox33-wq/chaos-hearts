$execute store result score #last ch.tmp run data get storage ch:data pvp[{k:$(k),v:$(v)}].t
$execute unless data storage ch:data pvp[{k:$(k),v:$(v)}] run scoreboard players set #last ch.tmp -999999
scoreboard players operation #gap ch.tmp = #now ch.g
scoreboard players operation #gap ch.tmp -= #last ch.tmp
execute if score #gap ch.tmp matches ..35999 run return run tellraw @s {text:"No mastery for killing the same player again so soon.",color:"dark_gray"}
$data remove storage ch:data pvp[{k:$(k),v:$(v)}]
$data modify storage ch:data pvp append value {k:$(k),v:$(v),t:0}
execute store result storage ch:data pvp[-1].t int 1 run scoreboard players get #now ch.g
scoreboard players operation #x ch.tmp = #xp_pvp_kill ch.cfg
function ch:mastery/award
