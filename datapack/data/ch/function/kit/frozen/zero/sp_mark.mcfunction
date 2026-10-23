# Frozen and marked.
execute store result score #f_ok ch.tmp run function ch:kit/frozen/freeze
tag @s add ch.frozen.sp
scoreboard players operation @s ch.frozen.spo = @a[tag=ch.caster,limit=1] ch.pid
execute positioned ~ ~1 ~ run function ch:api/fx/sprite3 {model:"crack",color:15924223,a:"[0.3,0.3,0.3]",b:"[1.6,1.6,1.6]",t:40,life:42,spin:170}
