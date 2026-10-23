# Inside the blizzard: 1.5 damage, slowed, freezing.
scoreboard players set #f_dmg ch.tmp 15
execute store result score #f_ok ch.tmp run function ch:kit/frozen/hurt
execute if score #f_ok ch.tmp matches 0 run return 0
function ch:api/cc {effect:"minecraft:slowness",sec:1,amp:1}
execute unless entity @s[type=player] run function ch:kit/frozen/bite_chill
execute if entity @s[type=player] run function ch:api/fx/screen {o:"frozen",color:"#F2FBFF",in:2,stay:10,out:10}
particle minecraft:snowflake ~ ~1.2 ~ 0.3 0.4 0.3 0.02 6
