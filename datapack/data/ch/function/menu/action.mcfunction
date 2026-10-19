# A button in one of the menus ran /trigger chmenu set <code>.
scoreboard players operation #c ch.tmp = @s chmenu
scoreboard players set @s chmenu 0
playsound chaoshearts:ui_click player @s ~ ~ ~ 0.5 1
execute if score #c ch.tmp matches 1 run return run function ch:menu/abilities
execute if score #c ch.tmp matches 3 run return run function ch:menu/feats
execute if score #c ch.tmp matches 4 run return run function ch:menu/hearts
execute if score #c ch.tmp matches 5 run return run function ch:menu/controls
execute if score #c ch.tmp matches 30 run return run function ch:menu/tree
execute if score #c ch.tmp matches 31 run return run function ch:menu/take {b:1}
execute if score #c ch.tmp matches 32 run return run function ch:menu/take {b:2}
execute if score #c ch.tmp matches 33 run return run function ch:menu/take {b:3}
execute if score #c ch.tmp matches 39 run return run function ch:menu/respec
execute if score #c ch.tmp matches 900 run return run function ch:trial/start
function ch:menu/main
