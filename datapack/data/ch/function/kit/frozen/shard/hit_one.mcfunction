# As a shard's target.
execute store result score #f_ok ch.tmp run function ch:kit/frozen/hurt
execute if score #f_ok ch.tmp matches 0 run return 0
execute if entity @a[tag=ch.caster,scores={ch.lvl=25..},limit=1] run function ch:kit/frozen/bite
function ch:api/cc {effect:"minecraft:slowness",sec:2,amp:1}
execute if entity @s[type=player] run function ch:api/fx/screen {o:"frozen",color:"#9BE7FF",in:1,stay:6,out:14}
execute if entity @a[tag=ch.caster,distance=30..,limit=1] as @a[tag=ch.caster,limit=1] run function ch:api/feat {h:"frozen",n:1}
particle minecraft:block{block_state:"minecraft:ice"} ~ ~1 ~ 0.25 0.4 0.25 0.1 14
playsound minecraft:block.glass.hit player @a ~ ~ ~ 0.8 1.4
