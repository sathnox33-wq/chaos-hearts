# As the target, with the caster tagged ch.caster: lightning damage #d ch.storm.g (+15% if Ionized), then ionizes it.
scoreboard players operation #zd ch.storm.g = #d ch.storm.g
execute if score @s ch.storm.ion matches 1.. run scoreboard players operation #zd ch.storm.g *= #c115 ch.storm.g
execute if score @s ch.storm.ion matches 1.. run scoreboard players operation #zd ch.storm.g /= #100 ch.g
execute store result storage ch:kstorm h.d int 1 run scoreboard players get #zd ch.storm.g
scoreboard players operation #h0 ch.storm.g = #hits ch.tmp
function ch:api/hit with storage ch:kstorm h
execute if score #hits ch.tmp > #h0 ch.storm.g if entity @a[tag=ch.caster,scores={ch.b3=4..},limit=1] run function ch:kit/storm/fn/ionize
particle minecraft:electric_spark ~ ~1 ~ 0.3 0.5 0.3 0.3 14
particle minecraft:dust{color:[0.91,0.96,1.0],scale:1.0} ~ ~1 ~ 0.3 0.5 0.3 0 6
execute if entity @s[type=player] run function ch:api/fx/screen {o:"storm",color:"#4FA8FF",in:0,stay:3,out:8}
