# As an enemy caught by Arc Snare.
scoreboard players add #n ch.storm.g 1
scoreboard players set @s ch.storm.teth 60
scoreboard players operation @s ch.storm.tow = #pid ch.storm.g
scoreboard players set #teth ch.storm.g 1
tag @s add ch.storm.nx
execute at @a[tag=ch.caster,limit=1] positioned ~ ~1 ~ run function ch:kit/storm/fn/arc
tag @s remove ch.storm.nx
function ch:kit/storm/fn/zap
execute if entity @s[type=player] run title @s subtitle {text:"Tethered! Stay close or be struck",color:"#9B7BFF"}
