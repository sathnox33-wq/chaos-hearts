# As the displaced target: lost in darkness and vertigo (Unravel adds Weakness); tracked for Switcheroo.
function ch:kit/void/afflict {e:"darkness",sec:3,amp:0}
function ch:kit/void/afflict {e:"nausea",sec:3,amp:0}
execute if entity @s[type=player] run function ch:kit/void/afflict {e:"blindness",sec:1,amp:0}
execute if entity @a[tag=ch.caster,scores={ch.b3=2..},limit=1] run function ch:kit/void/afflict {e:"weakness",sec:4,amp:0}
execute unless score #vvar ch.tmp matches 1 run scoreboard players set #vd ch.tmp 20
execute unless score #vvar ch.tmp matches 1 run function ch:kit/void/hurt
tag @s add ch.void.sw
scoreboard players operation @s ch.void.swo = @a[tag=ch.caster,limit=1] ch.pid
particle minecraft:squid_ink ~ ~1 ~ 0.3 0.5 0.3 0.05 20
execute if entity @s[type=player] run function ch:api/fx/screen {o:"void",color:"#14002B",in:1,stay:12,out:20}
execute if entity @s[type=player] run title @s subtitle {text:"Displaced",color:"#D38CFF",italic:true}
