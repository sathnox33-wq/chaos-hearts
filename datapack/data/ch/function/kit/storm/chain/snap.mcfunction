# The tether snaps: a heavy shock and a yank back toward the owner.
scoreboard players set @s ch.storm.teth 0
tag @a remove ch.caster
tag @a[tag=ch.storm.tw,limit=1] add ch.caster
scoreboard players set #d ch.storm.g 45
tag @s add ch.storm.nx
execute at @a[tag=ch.storm.tw,limit=1] positioned ~ ~1 ~ run function ch:kit/storm/fn/arc
tag @s remove ch.storm.nx
function ch:kit/storm/fn/zap
execute positioned as @a[tag=ch.storm.tw,limit=1] run function ch:api/pull {s:0.9}
function ch:api/fx/pillar {model:"beam",color:10189823,w:0.4,h:4.0,t:1,life:5}
playsound minecraft:entity.lightning_bolt.impact player @a ~ ~ ~ 1.2 1.1
function ch:api/fx/shake {s:3,t:6,r:1.5}
tag @a remove ch.caster
