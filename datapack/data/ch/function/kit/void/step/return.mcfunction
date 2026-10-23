# Awakened: return through your open rift, then Void Step goes on cooldown.
execute at @s run function ch:kit/void/step/vanish
execute at @e[type=marker,tag=ch.void.myrift,limit=1] run tp @s ~ ~ ~
execute at @s run function ch:kit/void/step/arrive
execute at @s run function ch:api/fx/sprite {model:"swirl",color:655380,s0:4.0,s1:0.1,t:6,life:8,spin:170,dy:0.0}
kill @e[type=marker,tag=ch.void.myrift]
execute if score @s ch.b1 matches 2.. run function ch:api/cooldown {slot:1,t:120}
execute unless score @s ch.b1 matches 2.. run function ch:api/cooldown {slot:1,t:160}
return 1
