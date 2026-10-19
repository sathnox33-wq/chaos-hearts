# Items a challenger dropped are sent to the altar they came from, everything else made by the trial goes away.
execute as @e[type=item,distance=..90] run function ch:trial/rescue_item
kill @e[tag=ch.tmob,type=!player,distance=..120]
kill @e[type=!player,type=!marker,type=!item_display,distance=..90]
kill @e[type=marker,tag=ch.session,distance=..2]
kill @e[tag=ch.fx,distance=..90]
execute if loaded ~ ~ ~ run function ch:trial/clear
