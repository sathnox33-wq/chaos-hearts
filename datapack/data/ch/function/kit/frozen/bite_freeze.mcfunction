# Full Frostbite: frozen solid; Deep Freeze progress.
scoreboard players set @s ch.frozen.fb 0
scoreboard players set #f_ft ch.tmp 30
execute store result score #f_ok ch.tmp run function ch:kit/frozen/freeze
execute if score #f_ok ch.tmp matches 0 run return 0
function ch:api/fx/text {text:"FROZEN",color:"#9BE7FF"}
scoreboard players add @a[tag=ch.caster,limit=1] ch.frozen.frz 1
execute as @a[tag=ch.caster,scores={ch.frozen.frz=10..},limit=1] run function ch:api/feat {h:"frozen",n:0}
