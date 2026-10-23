# On a kill inside the window: if the displaced target is gone, Switcheroo is earned.
scoreboard players operation #vme ch.tmp = @s ch.pid
scoreboard players set #vn ch.tmp 0
execute as @e[tag=ch.void.sw,distance=..128] if score @s ch.void.swo = #vme ch.tmp run scoreboard players add #vn ch.tmp 1
execute if score #vn ch.tmp matches 0 run function ch:api/feat {h:"void",n:2}
