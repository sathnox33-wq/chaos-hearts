# A kill in Avatar form: Living Inferno progress; Endless Pyre adds 2 seconds.
scoreboard players add @s ch.infernal.avk 1
execute if score @s ch.infernal.avk matches 3.. run function ch:api/feat {h:"infernal",n:3}
execute unless score @s ch.b3 matches 4.. run return 0
scoreboard players add @s ch.infernal.av 40
function ch:api/fx/text {text:"+2s",color:"#FFD23F"}
particle minecraft:flame ~ ~1 ~ 0.5 0.8 0.5 0.1 30
