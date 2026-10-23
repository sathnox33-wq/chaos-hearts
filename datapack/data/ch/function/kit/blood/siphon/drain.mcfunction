# Exsanguinate (Siphon, looking down): needs enemies bleeding from you within 12. Their blood is drawn out for
# 10 ticks (a thread from each), then it bursts.
scoreboard players operation #me ch.tmp = @s ch.pid
scoreboard players set #n ch.tmp 0
execute as @e[type=!#ch:ignore,tag=!ch.caster,distance=..12,scores={ch.blood.bleed=1..}] if score @s ch.blood.bo = #me ch.tmp run scoreboard players add #n ch.tmp 1
execute if score #n ch.tmp matches 0 run return run function ch:kit/blood/siphon/nobleed
scoreboard players set #ln ch.tmp 24
execute as @e[type=!#ch:ignore,tag=!ch.caster,distance=..12,scores={ch.blood.bleed=1..}] if score @s ch.blood.bo = #me ch.tmp at @s positioned ~ ~1 ~ facing entity @a[tag=ch.caster,limit=1] eyes run function ch:kit/blood/fx/line
execute positioned ~ ~1 ~ rotated 0 0 run function ch:api/fx/sprite {model:"swirl",color:10357535,s0:5.0,s1:0.4,t:10,life:11,spin:170,dy:0.0}
effect give @s minecraft:slowness 1 1 true
playsound minecraft:entity.warden.sonic_charge player @a ~ ~ ~ 1 1.8
playsound chaoshearts:blood_siphon player @a ~ ~ ~ 1 0.7
function ch:api/later {t:10,then:"ch:kit/blood/siphon/drain_go"}
return 1
