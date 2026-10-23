# As an enemy lifted by the anchored orb: hurled down into the ground.
function ch:kit/void/hurt
execute unless entity @s[type=player] unless entity @s[tag=ch.boss] run data modify entity @s Motion set value [0.0d,-2.6d,0.0d]
execute if entity @s[type=player] run effect clear @s minecraft:levitation
execute if entity @s[type=player] run function ch:kit/void/afflict {e:"slowness",sec:2,amp:2}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"shatter",color:"#8A3CFF",in:0,stay:3,out:10}
