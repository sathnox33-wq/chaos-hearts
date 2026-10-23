# As a target, caster tagged: one Frostbite stack (stacks fade after 5 s).
execute if entity @s[type=player,scores={ch.active=5}] run return 0
execute if entity @s[tag=ch.frozen.solid] run return 0
scoreboard players operation #f_dt ch.tmp = #now ch.g
scoreboard players operation #f_dt ch.tmp -= @s ch.frozen.fbt
execute if score #f_dt ch.tmp matches 100.. run scoreboard players set @s ch.frozen.fb 0
scoreboard players operation @s ch.frozen.fbt = #now ch.g
scoreboard players add @s ch.frozen.fb 1
scoreboard players set #f_fg ch.tmp 5
execute as @a[tag=ch.caster,scores={ch.active=5},limit=1] run function ch:kit/frozen/frost
scoreboard players set #f_need ch.tmp 5
execute if entity @a[tag=ch.caster,scores={ch.b1=1..},limit=1] run scoreboard players set #f_need ch.tmp 4
execute if score @s ch.frozen.fb >= #f_need ch.tmp run return run function ch:kit/frozen/bite_freeze
effect give @s minecraft:slowness 2 0 true
execute unless entity @s[type=player] run function ch:kit/frozen/bite_chill
particle minecraft:snowflake ~ ~1.4 ~ 0.3 0.3 0.3 0.04 8
execute rotated 0 0 positioned ~ ~1 ~ run function ch:api/fx/sprite {model:"ring",color:10217471,s0:0.4,s1:1.6,t:4,life:8,spin:150,dy:0.3}
execute if score @s ch.frozen.fb matches 1 run function ch:api/fx/text {text:"❄",color:"#9BE7FF"}
execute if score @s ch.frozen.fb matches 2 run function ch:api/fx/text {text:"❄❄",color:"#9BE7FF"}
execute if score @s ch.frozen.fb matches 3 run function ch:api/fx/text {text:"❄❄❄",color:"#9BE7FF"}
execute if score @s ch.frozen.fb matches 4.. run function ch:api/fx/text {text:"❄❄❄❄",color:"#C8F0FF"}
playsound minecraft:block.powder_snow.hit player @a ~ ~ ~ 0.8 1.2
