# The slam lands.
scoreboard players set @s ch.frozen.slam 0
tag @a remove ch.caster
tag @s add ch.caster
scoreboard players set #f_nf ch.tmp 30
function ch:kit/frozen/nova/burst {r:8,dia:16.0,d:52}
function ch:api/fx/shake {s:3,t:10,r:14}
execute rotated 0 0 positioned ~ ~0.06 ~ run function ch:api/fx/sprite {model:"crack",color:10217471,s0:3.0,s1:12.0,t:3,life:40,spin:0,dy:0.0}
particle minecraft:explosion ~ ~0.5 ~ 1.5 0.2 1.5 0 6
tag @s remove ch.caster
