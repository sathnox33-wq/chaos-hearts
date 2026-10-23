# Earthshatter: Golgoth raises its fists; red marks race toward you; then the ground erupts along them.
scoreboard players set @s ch.v1 140
scoreboard players set @s ch.v6 26
data merge entity @s {NoAI:1b}
function ch:trials/titan/callout {m:"Golgoth raises its fists... the ground splits! Step off the marked line."}
playsound minecraft:entity.iron_golem.attack master @a ~ ~ ~ 2 0.5
playsound minecraft:entity.ravager.roar master @a ~ ~ ~ 1.5 0.6
particle minecraft:lava ~ ~5 ~ 0.8 0.4 0.8 0 12
particle minecraft:flame ~ ~5 ~ 0.8 0.4 0.8 0.03 20
scoreboard players add #ti_cid ch.titan.cid 1
execute facing entity @a[tag=ch.challenger,limit=1] feet rotated ~ 0 run function ch:trials/titan/tf_spawn
execute if score @s ch.phase matches 2.. facing entity @a[tag=ch.challenger,limit=1] feet rotated ~25 0 run function ch:trials/titan/tf_spawn
execute if score @s ch.phase matches 2.. facing entity @a[tag=ch.challenger,limit=1] feet rotated ~-25 0 run function ch:trials/titan/tf_spawn
