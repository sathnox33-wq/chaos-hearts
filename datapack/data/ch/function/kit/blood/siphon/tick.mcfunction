# Siphon running, as the caster: draws the tethers and drinks every 10 ticks.
scoreboard players remove @s ch.blood.sip 1
scoreboard players set #tc ch.tmp 0
scoreboard players operation #m ch.tmp = @s ch.blood.sip
scoreboard players operation #m ch.tmp %= #10 ch.g
tag @s add ch.caster
execute as @e[tag=ch.blood.sipt,distance=..40] if score @s ch.blood.so = #me ch.tmp at @s run function ch:kit/blood/siphon/target
tag @s remove ch.caster
execute if score #tc ch.tmp matches 0 run scoreboard players set @s ch.blood.sip 0
execute if score @s ch.blood.sip matches ..0 run function ch:kit/blood/siphon/stop
