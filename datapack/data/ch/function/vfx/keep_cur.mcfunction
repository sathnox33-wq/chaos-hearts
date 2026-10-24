# Copies the palette in storage ch:vfx cur into the timeline marker just started (tag ch.vnew).
data modify entity @e[type=marker,tag=ch.vnew,limit=1] data merge from storage ch:vfx cur
